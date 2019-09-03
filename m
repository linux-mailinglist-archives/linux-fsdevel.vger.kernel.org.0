Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1CEA6939
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfICNE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 09:04:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfICNE7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WDdubMT5F5wNmO/6JU13bpheGre0HSUXt5GjH/gJ15c=; b=OsS7d9R1kVXGcZlxE+BK17GPxl
        ECD96UxW6oR8oCSyjbUqwjWgX3h3Hcfz/FtaJ/vNu9+Z16baaBRrJa59L7UctjpQxEe0eoepQyerY
        aTBF3VoVFu2fkyE4hIII3EVKZSqucpwPwVZiFs0OGJgfmffNlBTBwMMD605VUXtCiuqKHBJX4ansg
        atpx8D2c0IldrYaVbf91H9eko4VsVwChMMvewJK6Y23r0eogVkTYZ5kvhj9apFx4oWfFvr3F/Y6oV
        0a5wEBP4WNbNder7E+/ELmVz1HmrySoTS2Q/IBsyX56FlYd2rUpNhSZnC1G4OoS8xhQ5aHy+63GcU
        PsKmhvvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i58US-0003yD-6f; Tue, 03 Sep 2019 13:04:56 +0000
Date:   Tue, 3 Sep 2019 06:04:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Qian Cai <cai@lca.pw>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Message-ID: <20190903130456.GA9567@infradead.org>
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <20190903123719.GF1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903123719.GF1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 01:37:19PM +0100, Al Viro wrote:
> On Tue, Sep 03, 2019 at 12:21:36AM -0400, Qian Cai wrote:
> > The linux-next commit "fs/namei.c: keep track of nd->root refcount status” [1] causes boot panic on all
> > architectures here on today’s linux-next (0902). Reverted it will fix the issue.
> 
> <swearing>
> 
> OK, I see what's going on.  Incremental to be folded in:
> 
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 20ce2f917ef4..2ed0942a67f8 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -20,8 +20,8 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
>  #define LOOKUP_FOLLOW		0x0001	/* follow links at the end */
>  #define LOOKUP_DIRECTORY	0x0002	/* require a directory */
>  #define LOOKUP_AUTOMOUNT	0x0004  /* force terminal automount */
> -#define LOOKUP_EMPTY		0x4000	/* accept empty path [user_... only] */
> -#define LOOKUP_DOWN		0x8000	/* follow mounts in the starting point */
> +#define LOOKUP_EMPTY		0x8000	/* accept empty path [user_... only] */
> +#define LOOKUP_DOWN		0x10000	/* follow mounts in the starting point */
>  
>  #define LOOKUP_REVAL		0x0020	/* tell ->d_revalidate() to trust no cache */
>  #define LOOKUP_RCU		0x0040	/* RCU pathwalk mode; semi-internal */

Any chance to keep these ordered numerically to avoid someone else
introdcing this kind of bug again later on?
