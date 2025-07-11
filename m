Return-Path: <linux-fsdevel+bounces-54678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BB1B0220C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E715A710D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF652EF29A;
	Fri, 11 Jul 2025 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haAK98Co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D3F1A4F12;
	Fri, 11 Jul 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252093; cv=none; b=Jo5B2n4nwZDpqMuydiBIQD14UV/bwv7KLx+e7Mf9JdqQp7tOMX1CmwWFI8FpRCyNqr1o9cI1IG79BXO5bi5nJdIaOJVtJAGwuInI/0oO4kMcDa7QKOz9cCMdamB1u5Jv8fPj2R67XJYnAgHYGnpo4nFgNH0FrBnjDrtGOJXtK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252093; c=relaxed/simple;
	bh=9rTcGgjVO2euGtYJImM1UGsSk8RY4Ol9x0NC5uoFEDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swYUCQoMEMr8RLwP6Pztyxedamu5yeKZ9raFt8pZwuN/Q+lFO/JhDx9EpcNh7iAEhdibEOMTRrY3Pt9tMA0FcwA/4AHjxsHwpOJ/lJFuTMyLAMt9DT/7S+HdRXddm4uWA0zvkTxk5scE79D9qvlI+So6J4FSmSwKKLKbdADoKhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haAK98Co; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0c4945c76so367854866b.3;
        Fri, 11 Jul 2025 09:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752252090; x=1752856890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUG7Y34gLC/mpyqzJddNeDobUu/PZFQb7DYFa2YBA7A=;
        b=haAK98Cod94/ErfVWXrtXoaLN08pNUVoFLREJgWRj2kc3KP4Eaxm9FSHxybEVXkuy+
         99PS5kS+UpCdXOd6a3oM962WXH3GpbgL8o0uMVSbIXgFUNILs8evX5Y6Aw4jPUwGm3Us
         ZqICot+R6zByR6w3nOcz6dn2AEdjz4872TcA18HX9fj6nhVAaRH9kmXHYRgGxLCYtq0W
         IWmNUe87u0udQsXt6/sPcLQPqq1xCm/gv1yQwZClN/YhXvsLnPYmn1rWLQD6dsZxinRs
         IyPLsxvHRJmhKIpvSbG0tV+HdgTrZm7mRWdup3xe2LrM0vAo7Z4iPJf7xVZw69rOPoGy
         /T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752252090; x=1752856890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUG7Y34gLC/mpyqzJddNeDobUu/PZFQb7DYFa2YBA7A=;
        b=PQ6hJxZVrV+syCj2wtYNuDrzOoW5T3RaS2dqb41kXI5KbhR74iXS2nHyQwU5Wnbn6T
         qa9Kd1mcMNEqB2f891ZxAfkAVsg2wEJtKSTQTFpgHJ4XqdXfFW6c2s/JQ9hmSoH43eAx
         hR9UtjBSAt8sjoGPFVy9Sbd3Nsaj3/fuxEidVn4f7SFq4abbywxHX0cD8R3d7YaqKgbj
         0aYSIqSw13zE4F2+/TJLhILyONKbCGql+qcpICkIrGaol8Pqc/2I3BtY0Wj4LG5csMW/
         vzioFlHyZz0FroiADs3Yy98Ph+shayByKEXQpeGrqY7qezxmZ7A79bZnu8PE25wGunMc
         6aiA==
X-Forwarded-Encrypted: i=1; AJvYcCWnZI067/ekTXKUZ3INkUkOXeTyJHBBNfZNuVjZf0Iqh8w9ZwkVvCpabvqeSvDWgfN0yi7u+8VWgsA5htaU@vger.kernel.org, AJvYcCXALB6/zIINS7hUJ/Ria6WZ4mBmKTUrjhmIekSZYICDmBu8zFZxHQPK2k5+gwY/86ezJzE70gQW73z3XFk48Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUIhbpfg5lRceeFqV/ojcedom12vQBfCR1Wu8n08+xAwrtAc5S
	iG2IqdprHlCI9jVw0Qv0rNLARC8Xx3Lss59ieIn72o6DtnEy75S7UTUZOn2wYlpeetpmQzJI7jq
	pqtVo1K7Z37iAnowmaRUCAfzcC6orsGEXF2Emq/4=
X-Gm-Gg: ASbGncvu6T02+Q68FikJmRV5LwYQiDbUmHuXCSB39xgll7DV8dCaTZT7AkBgWmP/kXb
	VeXqnVqtnt+krMoIhs8OoXkiybrfF4hXq0CFwiU9YxVOG37aVzygwv1uWu/tc6d8lEq6JJJ1/CO
	mXZlk6koHtWp/ooanHm7WjRvqKD/ly+YjV0LnIhOR0OLqfw9XK1X6Ps96FasGI1Zn0BbDWWwnOf
	I4gUdk=
X-Google-Smtp-Source: AGHT+IFijcGR1Y+5RKwHmpeH47ZTRec8Nj/Xfbeylsd2imFmQeI5F5l//K9wmMUEHuljGI6eIkiOoA+WHVvamuqqoZQ=
X-Received: by 2002:a17:907:d582:b0:ae0:b49d:9cd with SMTP id
 a640c23a62f3a-ae6fc402e82mr432004466b.58.1752252089256; Fri, 11 Jul 2025
 09:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name>
In-Reply-To: <20250710232109.3014537-1-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 18:41:17 +0200
X-Gm-Features: Ac12FXxou1X0l3Xw1PUZOQIzv3pzanNzSto6zoYkBqJgWejGKMDI9RvAE_D4XYk
Message-ID: <CAOQ4uxhC_ARYQ=mPMEX9pLQTeXcBcJGqn8RK-tmE26W8pGChKA@mail.gmail.com>
Subject: Re: [PATCH 00/20 v2] ovl: narrow regions protected by i_rw_sem
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> This is a revised set of patches following helpful feedback.  There are
> now more patches, but they should be a lot easier to review.

I confirm that this set was "reviewable" :)

No major comments on my part, mostly petty nits.

I would prefer to see parent_lock/unlock helpers in vfs for v3,
but if you prefer to keep the prep patches internal to ovl, that's fine too=
.
In that case I'd prefer to use ovl_parent_lock/unlock, but if that's too
painful, don't bother.

Thanks,
Amir.

>
> These patches are all in a git tree at
>    https://github.com/neilbrown/linux/commits/pdirops
> though there a lot more patches there too - demonstrating what is to come=
.
> 0eaa1c629788 ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()
> is the last in the series posted here.
>
> I welcome further review.
>
> Original description:
>
> This series of patches for overlayfs is primarily focussed on preparing
> for some proposed changes to directory locking.  In the new scheme we
> will lock individual dentries in a directory rather than the whole
> directory.
>
> ovl currently will sometimes lock a directory on the upper filesystem
> and do a few different things while holding the lock.  This is
> incompatible with the new scheme.
>
> This series narrows the region of code protected by the directory lock,
> taking it multiple times when necessary.  This theoretically open up the
> possibilty of other changes happening on the upper filesytem between the
> unlock and the lock.  To some extent the patches guard against that by
> checking the dentries still have the expect parent after retaking the
> lock.  In general, I think ovl would have trouble if upperfs were being
> changed independantly, and I don't think the changes here increase the
> problem in any important way.
>
> I have tested this with fstests, both generic and unionfs tests.  I
> wouldn't be surprised if I missed something though, so please review
> carefully.
>
> After this series (with any needed changes) lands I will resubmit my
> change to vfs_rmdir() behaviour to have it drop the lock on error.  ovl
> will be much better positioned to handle that change.  It will come with
> the new "lookup_and_lock" API that I am proposing.
>
> Thanks,
> NeilBrown
>
>
>  [PATCH 01/20] ovl: simplify an error path in ovl_copy_up_workdir()
>  [PATCH 02/20] ovl: change ovl_create_index() to take write and dir
>  [PATCH 03/20] ovl: Call ovl_create_temp() without lock held.
>  [PATCH 04/20] ovl: narrow the locked region in ovl_copy_up_workdir()
>  [PATCH 05/20] ovl: narrow locking in ovl_create_upper()
>  [PATCH 06/20] ovl: narrow locking in ovl_clear_empty()
>  [PATCH 07/20] ovl: narrow locking in ovl_create_over_whiteout()
>  [PATCH 08/20] ovl: narrow locking in ovl_rename()
>  [PATCH 09/20] ovl: narrow locking in ovl_cleanup_whiteouts()
>  [PATCH 10/20] ovl: narrow locking in ovl_cleanup_index()
>  [PATCH 11/20] ovl: narrow locking in ovl_workdir_create()
>  [PATCH 12/20] ovl: narrow locking in ovl_indexdir_cleanup()
>  [PATCH 13/20] ovl: narrow locking in ovl_workdir_cleanup_recurse()
>  [PATCH 14/20] ovl: change ovl_workdir_cleanup() to take dir lock as
>  [PATCH 15/20] ovl: narrow locking on ovl_remove_and_whiteout()
>  [PATCH 16/20] ovl: change ovl_cleanup_and_whiteout() to take rename
>  [PATCH 17/20] ovl: narrow locking in ovl_whiteout()
>  [PATCH 18/20] ovl: narrow locking in ovl_check_rename_whiteout()
>  [PATCH 19/20] ovl: change ovl_create_real() to receive dentry parent
>  [PATCH 20/20] ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()

