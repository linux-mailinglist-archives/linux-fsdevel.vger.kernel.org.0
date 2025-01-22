Return-Path: <linux-fsdevel+bounces-39860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B99BA198D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 19:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A9C1881EE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 18:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1854215792;
	Wed, 22 Jan 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaKuLSFh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C71215166;
	Wed, 22 Jan 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572024; cv=none; b=dn+LoOm+to3Ftfj2o9KnN6lXNF+VEeEt6L2/ZNZodE6TVU+N3KcFzY77zeMeZX2fZ8xVWha3o9Mt4Ip4WGTQZGaCCq5Z7eit2qzkCnIoTLBwOs/yPuo5a87Exxdm5Ubq6pz6sgk23OkHEDIjyycjrwwqYoHilTZTaePFwJjnWug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572024; c=relaxed/simple;
	bh=6lkaNw8QxvHTPmA+G7VVF+NulwF+SEA37Tdn2huntXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHDra1NSheg1uzodckF8TuvN598ESpnizihd7a9A3Chm2dWhC5oRhZX0RDQIHgiSSCaGw3U/k5SR0ZXu8bnmbpbQmHTEt8iAxQBpC302o5Bh0bi+kTyajGu7KoovoQojnYJ6B7RZ0HQFYbbcBF2069zPjcJn5HSjOHeVmflWOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaKuLSFh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab651f1dd36so26325766b.0;
        Wed, 22 Jan 2025 10:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737572021; x=1738176821; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iJ5sZs+6TaySGO3RPSE9eCNoBfNNb/HbNo21ute/ZHU=;
        b=BaKuLSFhldOGKrx8MKdM2dqvuRFFe7ewv0RX7R7aMtOflUFpA+BUv4gx/832mIAiiO
         uigEnteB4R6VlHsgjG5V8gdX+awyHOiI2vp2SVoRq+II6iTq0SaLA2zqscGz2Jts3atA
         Sb7kPDCaDA2DE+NEbaC4WptJkf1VLdA/32qAMdCQfiebL1FcEgi2TiyMgxgxIjTesCti
         txgPA+kBIlrDUjywOYRn7uqHj/O7yNkMoNFVN0dFYq9m0crgMMZHfJb6c+AG8d+ssEet
         RG3gGZ70XFwKyFiz+uTWL3m5InS6zjgLZm2TGOEgXclX9y9srNIRC/305s4m8i9MmQ/Y
         VMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737572021; x=1738176821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJ5sZs+6TaySGO3RPSE9eCNoBfNNb/HbNo21ute/ZHU=;
        b=EMTGrRnVfCm1Eg76AQEVYkj8zTRU2lmXD99A1JCmlqnSg3GUC/uWmU3vATeBvjA627
         8SkhLzS9bxOyEpgmZ9XpXZUdlSdF+cGH3en9ZXZuth6dAwnKip6bO2Bu4E/h/QF1EfdL
         0eczM0vrbFFVyfxofERA98mDi4eI9L7/wypH6cUscpF64KmGRZ8y1Kny1qCt3ErzzE0q
         6/tTIT9k3183RRDHKfTkCfe7MaSy28l1l7yZZ5LQ5Sd3rjNtgtW19/UdVqeEaiv6JOJL
         Z7X9xmn0mCQZObw5FYFdqEh+w5+qoleVD9qzxLE4rLZXOyZeTgzjw06PQdb7g6o4+l78
         xk9w==
X-Forwarded-Encrypted: i=1; AJvYcCU5IKGl3ZdP8PH2bXdyo/JjnheuWft3Ep7Q7JUySSN/cwL139AXiD+DGmIo9qH8VEwYxXNk/Har3rJGSXmt@vger.kernel.org, AJvYcCXGUaUUTD7kXwVbLMDAr/wv81egVyv/5FQRfO/pwV8F39eZxEskjEZ7B7WS1RtsPKY+yM3xIQ0BrLdC@vger.kernel.org
X-Gm-Message-State: AOJu0YwSdcNcKy13k++ls2bnDE2f29/oI/w4FUg1sV3jj6YeWCE1KQEZ
	bIhEROFTx3ij2+Ir1AOZ76uoQIUNUd0/kKoFbhXB9rc/R3pmzaaKvdvFx5YROTuNs+23Jlrum+Z
	1A0OnWSmlsorSQGT2o7YUEZVp0ug=
X-Gm-Gg: ASbGncueo3bdPg7uGn7ZG4M+Motq9NmOUKSrA+ccnItiVycU3CXCGaSLL8/dn6kPz15
	1pbR2GRYaKmo0MSh4OZ1XkAk4pa2xP+RJmvD+/mGztpOAqNIvDSo=
X-Google-Smtp-Source: AGHT+IEalPkZChw6AcZLgevhrn3pNRowLBVy27Pnl7AdXloTuPCPHaL/IBPSqSuGOQaBtXbrxsGMgu294cHNUUsFaGU=
X-Received: by 2002:a17:906:6a26:b0:aa6:873b:ed8a with SMTP id
 a640c23a62f3a-ab38b4aa1aemr1909040866b.47.1737572020592; Wed, 22 Jan 2025
 10:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxh4PS0d6HuHCM_GTfNDpkM1EJ5G55Fs83tDRW0bGu2v-A@mail.gmail.com>
 <173750034870.22054.1620003974639602049@noble.neil.brown.name>
 <CAOQ4uxiXC8Xa7zEKYeJ0pADg3Mq19jpA6uEtZfG1QORzuZy9gQ@mail.gmail.com>
 <c2401cbe-eae9-44ab-b36c-5f91b42c430d@oracle.com> <CAOQ4uxi3=tLsRNyoJk4WPWK5fZrZG=o_8wYBM6f4Cc5Y48DbrA@mail.gmail.com>
 <50c4f76e-0d5b-41a7-921e-32c812bd92f3@oracle.com>
In-Reply-To: <50c4f76e-0d5b-41a7-921e-32c812bd92f3@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Jan 2025 19:53:29 +0100
X-Gm-Features: AWEUYZl9AsmnMiSSa5gRC4g6-j4zUfXV71i1azOd7R7MILWRjLqo4_2FjGz8l_I
Message-ID: <CAOQ4uxiVLTv94=Xkiqw4NJHa8RysE3bGDx64TLuLF+nxkOh-Eg@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@hammerspace.com>, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"

> > I am fine with handling EBUSY in unlink/rmdir/rename/open
> > only for now if that is what everyone prefers.
>
> As far as I can tell, NFSv2 and NFSv3 REMOVE/RMDIR are working
> correctly. NFSv4 REMOVE needs to return a status code that depends
> on whether the target object is a file or not. Probably not much more
> than something like this:
>
>         status = vfs_unlink( ... );
> +       /* RFC 8881 Section 18.25.4 paragraph 5 */
> +       if (status == nfserr_file_open && !S_ISREG(...))
> +               status = nfserr_access;
>
> added to nfsd4_remove().

Don't you think it's a bit awkward mapping back and forth like this?
Don't you think something like this is a more sane way to keep the
mapping rules in one place:

@@ -111,6 +111,26 @@ nfserrno (int errno)
        return nfserr_io;
 }

+static __be32
+nfsd_map_errno(int host_err, int may_flags, int type)
+{
+       switch (host_err) {
+       case -EBUSY:
+               /*
+                * According to RFC 8881 Section 18.25.4 paragraph 5,
+                * removal of regular file can fail with NFS4ERR_FILE_OPEN.
+                * For failure to remove directory we return NFS4ERR_ACCESS,
+                * same as NFS4ERR_FILE_OPEN is mapped in v3 and v2.
+                */
+               if (may_flags == NFSD_MAY_REMOVE && type == S_IFREG)
+                       return nfserr_file_open;
+               else
+                       return nfserr_acces;
+       }
+
+       return nfserrno(host_err);
+}
+
 /*
  * Called from nfsd_lookup and encode_dirent. Check if we have crossed
  * a mount point.
@@ -2006,14 +2026,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct
svc_fh *fhp, int type,
 out_drop_write:
        fh_drop_write(fhp);
 out_nfserr:
-       if (host_err == -EBUSY) {
-               /* name is mounted-on. There is no perfect
-                * error status.
-                */
-               err = nfserr_file_open;
-       } else {
-               err = nfserrno(host_err);
-       }
+       err = nfsd_map_errno(host_err, NFSD_MAY_REMOVE, type);
 out:
        return err;

>
> Let's visit RENAME once that is addressed.

And then next patch would be:

@@ -1828,6 +1828,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct
svc_fh *ffhp, char *fname, int flen,
        __be32          err;
        int             host_err;
        bool            close_cached = false;
+       int             type;

        err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
        if (err)
@@ -1922,8 +1923,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct
svc_fh *ffhp, char *fname, int flen,
  out_dput_new:
        dput(ndentry);
  out_dput_old:
+       type = d_inode(odentry)->i_mode & S_IFMT;
        dput(odentry);
  out_nfserr:
-        err = nfserrno(host_err);
+       err = nfsd_map_errno(host_err, NFSD_MAY_REMOVE, type);

>
> Then handle OPEN as a third patch, because I bet we are going to meet
> some complications there.
>
>

Did you think of anything better to do for OPEN other than NFS4ERR_ACCESS?

Thanks,
Amir.

