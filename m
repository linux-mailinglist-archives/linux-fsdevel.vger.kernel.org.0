Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B6020428D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 23:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgFVVXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 17:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbgFVVXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:23:08 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357F3C061573;
        Mon, 22 Jun 2020 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hPBi1Ca/ygGxeQUdNKQzKk5MNJppiF11w9HoER8rk1Q=; b=k8Y3QFkIq+BeFyvt43VXR17p8+
        mQX77gJVujEvu7+d5QYfMAUus0U6EDtfwaYPIrKAiSAlaxIEgGXRXzcNfhPYrSGUMVMibLczDd3kR
        HbMmpgxLVefe2/H5tg6WIPAITTeYDEgrXUc2nwCKIk2EwADK6sjKSigIsO479qbZKEHJXY1oz9LFs
        /IhT8l/A90yd8SDSbSmjRre1ZKWY/m8SzZMB5S76nlknqBYF2+zDjrYRq69xEarKz2FFnArt5euFJ
        Nnby+PwzqIyZvPhm1vtFX2ARMEeU/tCDuEDCVWLTM7J08PemZKQ0y/w8fUMG62SaJ8ta+ETKAn4nb
        OjzFLyHA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnTtu-0000Lo-1U; Mon, 22 Jun 2020 21:22:46 +0000
Date:   Mon, 22 Jun 2020 22:22:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Egor Chelak <egor.chelak@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: fix High Sierra dirent flag accesses
Message-ID: <20200622212245.GC21350@casper.infradead.org>
References: <20200621040817.3388-1-egor.chelak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621040817.3388-1-egor.chelak@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 21, 2020 at 07:08:17AM +0300, Egor Chelak wrote:
> The flags byte of the dirent was accessed as de->flags[0] in a couple of
> places, and not as de->flags[-sbi->s_high_sierra], which is how it's
> accessed elsewhere. This caused a bug, where some files on an HSF disc
> could be inaccessible.

> +++ b/fs/isofs/dir.c
> @@ -50,6 +50,7 @@ int isofs_name_translate(struct iso_directory_record *de, char *new, struct inod
>  int get_acorn_filename(struct iso_directory_record *de,
>  			    char *retname, struct inode *inode)
>  {
> +	struct isofs_sb_info *sbi = ISOFS_SB(inode->i_sb);
>  	int std;
>  	unsigned char *chr;
>  	int retnamlen = isofs_name_translate(de, retname, inode);
> @@ -66,7 +67,7 @@ int get_acorn_filename(struct iso_directory_record *de,
>  		return retnamlen;
>  	if ((*retname == '_') && ((chr[19] & 1) == 1))
>  		*retname = '!';
> -	if (((de->flags[0] & 2) == 0) && (chr[13] == 0xff)
> +	if (((de->flags[-sbi->s_high_sierra] & 2) == 0) && (chr[13] == 0xff)
>  		&& ((chr[12] & 0xf0) == 0xf0)) {
>  		retname[retnamlen] = ',';
>  		sprintf(retname+retnamlen+1, "%3.3x",

It's been about 22 years since I contributed the patch which added
support for the Acorn extensions ;-)  But I'm pretty sure that it's not
possible to have an Acorn CD-ROM that is also an HSF CD-ROM.  That is,
all Acorn formatted CD-ROMs are ISO-9660 compatible.  So I think this
chunk of the patch is not required.

