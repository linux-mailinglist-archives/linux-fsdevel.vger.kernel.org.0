Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CB021829C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 10:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgGHIgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 04:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgGHIgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:36:46 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA8FC08E81A
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 01:36:45 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a21so13070511otq.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 01:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9OfFYHbH3ZToik4MArfMg4xPvvnpVtVORAGHHfFrzw=;
        b=a7N5EXkH5q7VpSLTWAozI5gExPwpPLyEBtcnr+2Joyigm0wqh9O962IoDSEkQkNe24
         G0b7x3cdw0AGEOwCagxOmuU2zD2rueVP3jFwJ1lbf3nWWdqZWtyp4KjV6oVZfok6JToX
         b5iZD6fEW2fOrcX3fUDiv4C44gQbHmEgFQDXN+gKgfNQoiyXhwA+X+OmAU2s1fIInzLD
         8Fc1+guNZyjLcgN0szNlMFiaHA+C8wUa8soG5hVGc84IlOyq2splKLjARL+IhmghncC1
         Bv3M94PQA+S5+1aPAntPl45rQ9Ut5fxU8s3HhGRLBtk06ZEBoz9M7eo06qvjRzHsHzTl
         8GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9OfFYHbH3ZToik4MArfMg4xPvvnpVtVORAGHHfFrzw=;
        b=eu4RGMdv9AITgtOIQodJ+HbN8Ts/XX0EPIp0TY7Ij+T6oSp0XQ+HEX1/0HoQeingoG
         AgYkOMjn7cOkIVIu468TBqH5WK1AtTknzBA9UXqwVSQwSp/WWqsVqTWEg7XIdRmJOMUp
         ZDDXIm0MjAxf+Y2AffUB9T1ysPA6zwqJYZlhl7xD5eeXXEPnh1mxX/B7p+la5UqekbHD
         6o39RjqsJozkKMWJ2xqDGpVO1sDs0zh/FTzFTIJecEElquUWxJxwJ/QKEOmmSRZezqcP
         JlfeXrMu19k0TZnS7c1PX8SoDMEVSTgaXVCfq8MpzFc4qAwpuZyLVJEH4mb2NndpXxDx
         NLXA==
X-Gm-Message-State: AOAM532lt0cHuECtVtiad7QZbT4hYXmPt5aojtUYVPdO+hbG9ab7qMYn
        bgXCs5ikdZke/Xp/ph8d/L+VJRpRUNhS/enQcHn/nA==
X-Google-Smtp-Source: ABdhPJwKsuIiJfQBK+Z2FyMDKuMkojZ6lgZ1RE3obfX6zdiVrn4CkzrMBfnMstVN4ibNoDkOfiQQ4zMF5Hlxev2KtTc=
X-Received: by 2002:a9d:6d98:: with SMTP id x24mr38406495otp.93.1594197404821;
 Wed, 08 Jul 2020 01:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200708030552.3829094-1-drosen@google.com> <20200708030552.3829094-3-drosen@google.com>
 <20200708041230.GL839@sol.localdomain>
In-Reply-To: <20200708041230.GL839@sol.localdomain>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Wed, 8 Jul 2020 01:36:33 -0700
Message-ID: <CA+PiJmQP+kJQeCZ0LFqRcN6JYWF6pAUHaTnFOThmDLtLTveOXg@mail.gmail.com>
Subject: Re: [PATCH v11 2/4] fs: Add standard casefolding support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 7, 2020 at 9:12 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jul 07, 2020 at 08:05:50PM -0700, Daniel Rosenberg wrote:
> > +/**
> > + * generic_ci_d_compare - generic d_compare implementation for casefolding filesystems
> > + * @dentry:  dentry whose name we are checking against
> > + * @len:     len of name of dentry
> > + * @str:     str pointer to name of dentry
> > + * @name:    Name to compare against
> > + *
> > + * Return: 0 if names match, 1 if mismatch, or -ERRNO
> > + */
> > +int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
> > +                       const char *str, const struct qstr *name)
> > +{
> > +     const struct dentry *parent = READ_ONCE(dentry->d_parent);
> > +     const struct inode *inode = READ_ONCE(parent->d_inode);
>
> How about calling the 'inode' variable 'dir' instead?
>
> That would help avoid confusion about what is the directory and what is a file
> in the directory.
>
> Likewise in generic_ci_d_hash().
>
> > +/**
> > + * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
> > + * @dentry:  dentry whose name we are hashing
>
> This comment for @dentry needs to be updated.
>
> It's the parent dentry, not the dentry whose name we are hashing.
>
> > + * @str:     qstr of name whose hash we should fill in
> > + *
> > + * Return: 0 if hash was successful, or -ERRNO
>
> As I mentioned on v9, this can also return 0 if the hashing was not done because
> it wants to fallback to the standard hashing.  Can you please fix the comment?
>
> > +int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
> > +{
> > +     const struct inode *inode = READ_ONCE(dentry->d_inode);
> > +     struct super_block *sb = dentry->d_sb;
> > +     const struct unicode_map *um = sb->s_encoding;
> > +     int ret = 0;
> > +
> > +     if (!inode || !needs_casefold(inode))
> > +             return 0;
> > +
> > +     ret = utf8_casefold_hash(um, dentry, str);
> > +     if (ret < 0)
> > +             goto err;
> > +
> > +     return 0;
> > +err:
> > +     if (sb_has_strict_encoding(sb))
> > +             ret = -EINVAL;
> > +     else
> > +             ret = 0;
> > +     return ret;
> > +}
>
> On v9, Gabriel suggested simplifying this to:
>
>         ret = utf8_casefold_hash(um, dentry, str);
>         if (ret < 0 && sb_has_enc_strict_mode(sb))
>                 return -EINVAL;
>         return 0;
>
> Any reason not to do that?
>
> - Eric

Guh, I remember making those changes, must've lost them in a rebase :(
I'll resend shortly.
-Daniel
