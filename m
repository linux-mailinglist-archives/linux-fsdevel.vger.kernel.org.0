Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE30342B06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409442AbfFLPfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 11:35:54 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42286 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408737AbfFLPfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:35:53 -0400
Received: by mail-yw1-f67.google.com with SMTP id s5so6980200ywd.9;
        Wed, 12 Jun 2019 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVqB7YE74nX8aIvvaNFGMFzyVCCePygI3vzcXxakjiM=;
        b=lCrIGdDbQcM5aOCLBaAmvj8EH2N7WKJAp5/qm1M1WlW+1bO20uvKpdBAiP6uRNDoZL
         nLB1p+sxvVEbqdwd2bVYMkqJ567jpN6g172z3nF2PWjjtLfNRu1rjY8SWrTktdVHKG7b
         bDxxh1nUP6ZtXVrODdtEh6TQ3+AH+NOP9b1aAumm4VjU1EuXLM8ou5jLJ0U3sJ9ukow5
         w+buVPNB+jxJhfMaAajypr0d4dfoVhrDIv7iz12wArA3bMqPQHR3grnJu07A3Y4/7i06
         3Su/dtBwZfHXmUBHy5ykeESqGv8HubmNnYIz+61BfuhAWsWifYUCE65+pLzisaRBq6UG
         VC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVqB7YE74nX8aIvvaNFGMFzyVCCePygI3vzcXxakjiM=;
        b=uE2nJkuRNBQcxCj7C21UTQ5gMXRzZzcsRGejTSDDmdfisOz/6lnlu4g5IrHBk2ydCA
         d8p7Xg8v34XkVyqD/aa6FULDBTzHJAbpVMDbbSpKaXNRUZ25i1IkIDySi/2oMwNAMn2c
         ZkQ5sXppGG3lxD8FQ2VKWEqFylspzVVAN3jw4+CnC7A90Z0GEijWrVlRzsXEMzkBMer6
         zd5pCrcLH2PmfWwtD7WRUEiRc+gFshePyuHMNaDK+KHuzi/HOIAprrLacVsi70y32nhN
         F6hgzw+4yRczeB/JfjxyfxG4SCQK8CXcuxx8+ogjDzfeyaT8tgJgfpN6s+R56/21adEA
         9YXA==
X-Gm-Message-State: APjAAAU1rQVoQNg3nbA2DSlDQ9LyPbcnBWPUw5SprqO9SU9zcp9/nRrT
        lKXCtUGQkixRlWB5MEIQWvDFHSiYN8LfreiawLk=
X-Google-Smtp-Source: APXvYqwpV2WzvY1Ctlc+vR7ZMgZl+z/AGXquabGVw5wCC7sPZo0RMy2RzAFlZ8vOSu4LF9piIprfC0Fc2yVhwPtEVSE=
X-Received: by 2002:a81:910a:: with SMTP id i10mr30308887ywg.31.1560353752324;
 Wed, 12 Jun 2019 08:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190608135717.8472-1-amir73il@gmail.com> <20190608135717.8472-2-amir73il@gmail.com>
 <1560343899.4578.9.camel@linux.ibm.com> <CAOQ4uxhooVwtHcDCr4hu+ovzKGUdWfQ+3F3nbgK3HXgV+fUK9w@mail.gmail.com>
 <20190612152927.GE16331@fieldses.org>
In-Reply-To: <20190612152927.GE16331@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 12 Jun 2019 18:35:39 +0300
Message-ID: <CAOQ4uxgbzF_e7Z4zQbNp0B51Bh1hjw3c3p=QMk4bFWjOuAjQLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: replace i_readcount with a biased i_count
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@poochiereds.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 6:29 PM J . Bruce Fields <bfields@fieldses.org> wrote:
>
> On Wed, Jun 12, 2019 at 06:09:59PM +0300, Amir Goldstein wrote:
> > But if I am following Miklos' suggestion to make i_count 64bit, inode
> > struct size is going to grow for 32bit arch when  CONFIG_IMA is not
> > defined, so to reduce impact, I will keep i_readcount as a separate
> > member and let it be defined also when BITS_PER_LONG == 64
> > and implement inode_is_open_rdonly() using d_count and i_count
> > when i_readcount is not defined.
>
> How bad would it be just to let the inode be a little bigger?  How big
> is it already on 32 bit architectures?  How much does this change e.g.
> how many inodes you can cache per megabyte?
>

It's hard to answer how tiny changes like this impact users with different
configs, especially to IoT ones, so I do not like increasing size of inode
unconditionally, but I will go with:
-#ifdef CONFIG_IMA
+#if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
        atomic_t                i_readcount; /* struct files open RO */
 #endif

So IoT guys can have an option to keep inode size the same
and not let the locks code worry about it.

OK?

Thanks,
Amir.
