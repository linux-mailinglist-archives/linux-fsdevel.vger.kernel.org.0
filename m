Return-Path: <linux-fsdevel+bounces-15914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACC4895CD3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 21:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3291C20883
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 19:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C938C15CD44;
	Tue,  2 Apr 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GrZeNhqn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBA115B97A
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086789; cv=none; b=M7XzEv0B/RRVHrZQsmSYzMgszrNCVmjLcemiS3sOqna3j7Cg8RBOYNGxlZDDx657z3voRSas/2vwwMU4XWa9PEG/raI8UVRIp7IFlGjFd/pjeHIfSfjOOW9SQNcMPWylKqZuiw5tPLn6qbZuLe1ZNbSZOYkJJmyBOPcn2+BooR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086789; c=relaxed/simple;
	bh=FUitx7MgiMoEaaLuPTTMRh2BBePYzO9uMUChIAgHet4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNekp8KUKtnkTcs918bG2Vf9s5/csKHsIm7RxrgoMIsAuJWW7v/RgJK1QEKCO2uhU6WeFcCokuQDy6QmdJ1xwoD8MnlJ/JYbVTBrUEyV7kcO8NInecq5e2b1mp2dx5rN8GFVKm3YfaIMRa/4NVgaFiEt0750Bhmoah4JtunXSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GrZeNhqn; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso4249645a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712086784; x=1712691584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0mQeGyOEkrbKK1USpW42EOtHV5nHSHeR2mY3J6ZfsUg=;
        b=GrZeNhqnkcLYGTX+yyG8BOagRjmaAaJP+ErkV4Bp8cauJzqpnp5AwAqyfvWool1JFd
         k1GpkgNzfn7bVylSi+EFxe9r/r5bvAyV71XWS94KPGoo2xFBYwiLHXbOyHADn4w8UPxv
         FPuxU66l2HUTfxQGTOidDYyYD6P01dNCgbHdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086784; x=1712691584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mQeGyOEkrbKK1USpW42EOtHV5nHSHeR2mY3J6ZfsUg=;
        b=uW15Or5BhQDVp/naQbc7Q24qOtszM+0oNJ2WGXMPRAwsv5yqyDia2SHBiQko1n7dM7
         lXPYA1Ywki7RAprp7PaNfxvmkv0Illy2D9qcVXv/KwTa8ex7vuq77VPrJEXJaIfdTqGc
         Xuf744RwR+NLq/iBS3FgkY3WGXyYBLtgUkEFRs4aHlm+bXQAFEuDSU1UQucYiaM7iFow
         HzTd5GmUNORoYupeQ2olJojcNfoq7+OknN26Mr1WZUJDxTnPoYrKzm/UuX5IBQY+4mve
         jq7tmptpN3xocuNZ61P7ZsR3cAF+9MYtaLykbrScw5nCmHwuylpjcrxS1Mx5lZcfoO/Y
         kmAA==
X-Forwarded-Encrypted: i=1; AJvYcCVrPOvE4UXDokZ7bejAoPoYRz6VnYvyCC3sTbo5K+aZC2TugbCT7Jzj7DCAr/WczVumTBNAga41eu4HDUyGsT+XJ41Ol11bxO1iKr81gA==
X-Gm-Message-State: AOJu0YzWdyfhSh6yVDD7oNUWEIKdcJRr3vz/ttcnzV88rF7AOgjHpv3m
	8ef26m0RQIRG7u7VPdMe424ZePRCzCJsEN9eNuhtDzRgK+yBMLxbqf2Wwes9weW/Wg/bVOWMBaG
	hcQE=
X-Google-Smtp-Source: AGHT+IFQiyejVHbqMboaWpyRD/jsi8awGY+FeId7TVX+6SMZfujgiXG9vazFFFVatVf09cULp5YmtQ==
X-Received: by 2002:a05:6402:50ca:b0:56b:817a:5bcf with SMTP id h10-20020a05640250ca00b0056b817a5bcfmr10284250edb.5.1712086784644;
        Tue, 02 Apr 2024 12:39:44 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id ef15-20020a05640228cf00b0056c1380a972sm7038800edb.74.2024.04.02.12.39.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 12:39:43 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c0a249bacso6849640a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 12:39:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTI5QzPymekQGtLR7V2v2GebXKXrm7Bd+kmNxx+2ICHN68aEmaS0CWPZ+QQ9WoZN7m51WxWuC3AC8Gv5JI5mDlzAH6JI5p+aBxXs8wpg==
X-Received: by 2002:a17:906:2698:b0:a47:4d61:de44 with SMTP id
 t24-20020a170906269800b00a474d61de44mr8673776ejc.55.1712086783205; Tue, 02
 Apr 2024 12:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Apr 2024 12:39:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
Message-ID: <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 07:12, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> A single bug fix to address a kernel panic in the newly introduced function
> security_path_post_mknod.

So I've pulled from you before, but I still don't have a signature
chain for your key (not that I can even find the key itself, much less
a signature chain).

Last time I pulled, it was after having everybody else just verify the
actual commit.

This time, the commit looks like a valid "avoid NULL", but I have to
say that I also think the security layer code in question is ENTIRELY
WRONG.

IOW, as far as I can tell, the mknod() system call may indeed leave
the dentry unhashed, and rely on anybody who then wants to use the new
special file to just do a "lookup()" to actually use it.

HOWEVER.

That also means that the whole notion of "post_path_mknod() is
complete and utter hoghwash. There is not anything that the security
layer can possibly validly do.

End result: instead of checking the 'inode' for NULL, I think the
right fix is to remove that meaningless security hook. It cannot do
anything sane, since one option is always 'the inode hasn't been
initialized yet".

Put another way: any security hook that checks inode in
security_path_post_mknod() seems simply buggy.

But if we really want to do this ("if mknod creates a positive dentry,
I won't see it in lookup, so I want to appraise it now"), then we
should just deal with this in the generic layer with some hack like
this:

  --- a/security/security.c
  +++ b/security/security.c
  @@ -1801,7 +1801,8 @@ EXPORT_SYMBOL(security_path_mknod);
    */
   void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
   {
  -     if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
  +     struct inode *inode = d_backing_inode(dentry);
  +     if (unlikely(!inode || IS_PRIVATE(inode)))
                return;
        call_void_hook(path_post_mknod, idmap, dentry);
   }

and IMA and EVM would have to do any validation at lookup() time for
the cases where the dentry wasn't hashed by ->mknod.

Anyway, all of this is to say that I don't feel like I can pull this without
 (a) more acks by people
and
 (b) explanations for why the simpler fix to just
security_path_post_mknod() isn't the right fix.

                 Linus

