Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757C947B3AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 20:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbhLTT0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 14:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhLTT0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:26:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CF1C061574;
        Mon, 20 Dec 2021 11:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=xnRmLOl8H6zbhMlGxuFOZlowEJmSeWLTYW9sSlqPOv8=; b=gvExG3lrTxj8yWATXLRc0twGzT
        ofZwYG3Vq+7HFWa2swBlmTt63TRZjAp5r+3HgtxOeiNlDWS6blXpY+pCTGXMo5tZze+Q3c/5TrhXx
        Gk5ElaLnqHlHgBrW2MUJpo/rIPURCIrSyen1xXpWEAjyuwdhXb8v4mHDAP5s08srHQ26gERuYaxmH
        sPUI09zPHMrvABnSILc4L/qdUQYyRj3h8nL+WPj80/HxB08i5CeazUcBk2aZf7TOMa+EP6uXZXjr9
        O/l/257yTPapaLxfsTIAz/hsJ1GQJetDlDMpg4ouyQHIbyrZZmegD1vy4bthXciUtldg94ZHUGkpz
        UEDjbtXw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzOI1-004506-NX; Mon, 20 Dec 2021 19:25:41 +0000
Date:   Mon, 20 Dec 2021 11:25:41 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] sysctl: move maxolduid as a sysctl specific const
Message-ID: <YcDYtcJG+ON1bowf@bombadil.infradead.org>
References: <20211129205548.605569-1-mcgrof@kernel.org>
 <20211129205548.605569-5-mcgrof@kernel.org>
 <d20861d0-8432-76d7-bcda-1b80401e0a22@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d20861d0-8432-76d7-bcda-1b80401e0a22@digikod.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 17, 2021 at 05:15:01PM +0100, Mickaël Salaün wrote:
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index 7dec3d5a9ed4..675b625fa898 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -26,7 +26,7 @@ static const struct file_operations proc_sys_dir_file_operations;
> >   static const struct inode_operations proc_sys_dir_operations;
> >   /* shared constants to be used in various sysctls */
> > -const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, INT_MAX };
> > +const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 65535, INT_MAX };
> 
> The new SYSCTL_MAXOLDUID uses the index 10 of sysctl_vals[] but the same
> commit replaces index 8 (SYSCTL_THREE_THOUSAND used by
> vm.watermark_scale_factor) instead of adding a new entry.
> 
> It should be:
> +const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, INT_MAX,
> 65535 };

Can you send a proper patch which properly fixes this and identifies
the commit name with a Fixes tag. Since thi sis on Andrew's tree no
commit ID is required given that they are ephemeral.

  Luis
