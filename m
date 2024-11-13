Return-Path: <linux-fsdevel+bounces-34692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB59C7BCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 20:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E81E5B39C78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756AF20495A;
	Wed, 13 Nov 2024 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTO6Xv3N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8817202647;
	Wed, 13 Nov 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524237; cv=none; b=FsgtpLtJaD7bc9agOcZuuhA8okeOZc3Lvlz+GZTLmMTbrEt8pD5UCyPTrljkS3gXrIGF3EmyRGfqPddeWma55eQ2Q9RiF01Q8tnAyp/k81JzLa7p89peVEVKlccmgZFaKRXEV9xQkFccuJs+rTSMF0RNxY+p3YjTFAiJsFRze3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524237; c=relaxed/simple;
	bh=5wZKxu12qYihpmKa28+AtTnrGYmnzuouLS+qJVdqhyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUKsFo+YGC8zXomN5mUqFFkUbDlUirnSMpN/5uHA9YCVTUBXea5k8Wku5VYJwAk0DLkvp6b3Rh3kZcQSxJ6WZEJMivBwIyuCLLofLdtG1LGwmiPO9e+NE9vk8U70b8BJfkoF4YeZEkYApxrYgwu3jJwbmvtyO3iFubD+BNFnOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTO6Xv3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57745C4CEDA;
	Wed, 13 Nov 2024 18:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731524237;
	bh=5wZKxu12qYihpmKa28+AtTnrGYmnzuouLS+qJVdqhyI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QTO6Xv3Nzt1Sl1cSrVwDdF3CxydDl38AarSD2qHMSu6MFkwSl9Zy2wTBo+UYceLYn
	 z/ycXiHgR2YwuQ3MbS5VfNKbRIiT/L/4EKjpuRo0WqmiQUDgjnRemidHu1C+tiIVLE
	 Q3nFJUJVYj5voKZ0E44SCdAtis1Yv6Rm2AfbVGpcw4EelbXHV1lGRgbylxlsrpoJ8Q
	 MhiABYdfsewy7EhEZR+wLIJASxGVFWdWxRep/x3S8132CaGDFVC4Oa+sduyO9yGIFE
	 ugdq7OTVaFfIdCJLyF14MEHKRqrUjelQ2U9v7Xhj65VFuVeRvzlFY2dAjB/QzOHNKe
	 D1n2U9Mzw0zSg==
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a6bf539cabso25687115ab.3;
        Wed, 13 Nov 2024 10:57:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhh3x6ge0UJ9wcZaRC+pOtq3G5JImbxWfeL2IuCnJ/qUVm5SydBi1sXYTmeR40crndjA7M2DtgfEpKr3jYIGrMBu71Qxpu@vger.kernel.org, AJvYcCWOe4GO6rWXSjD0y4729j2tEJTDoWlSI6nbcDZr+dm2+tk2ptzqmx0TYRCpP2PclNBEodk=@vger.kernel.org, AJvYcCXH6Vi6d5j8uvxCVi5ySbFrru1pKWVzhwemkWlc3F2OcyewbdRiEuSBhdRuKBqw9EmykxPIgN0S8X5f+WzS@vger.kernel.org, AJvYcCXRJsUNklM4CWM7synqYYjuRa2SwR/DUH9kOKB6t6cKI+YjCY7j6dpB/wjapDBpB2j4V59E+CtkEH5dB/C0hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/CqG1yBAPZMXUMSOOqr2Fa4intdkc36Pc23PUDh20q3Sieve
	vlZVANMz4dtDhJ8HsJxouwKwckHudUcKM+JRB3RC9pnzwpiCEXr22HCdOD2+nUto5wAunxY+Du6
	+XbmgMuheIdMM0jENsVBXl2MxqBY=
X-Google-Smtp-Source: AGHT+IFRUe2R/KYe/0g+BBuwonrcFhhroRTWjnMS2oIC1YXoUQZfpRdPFs2YH+Q3iuxsU6xarKf1JgvIqeEdqoMJdQs=
X-Received: by 2002:a05:6e02:1b0e:b0:3a7:1d09:d90e with SMTP id
 e9e14a558f8ab-3a71d09db79mr14105765ab.15.1731524236545; Wed, 13 Nov 2024
 10:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112082600.298035-1-song@kernel.org> <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com>
 <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com> <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
 <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com> <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
In-Reply-To: <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
From: Song Liu <song@kernel.org>
Date: Wed, 13 Nov 2024 10:57:05 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
Message-ID: <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Song Liu <songliubraving@meta.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "amir73il@gmail.com" <amir73il@gmail.com>, 
	"repnop@google.com" <repnop@google.com>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 10:06=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 11/12/2024 5:37 PM, Song Liu wrote:
[...]
> > Could you provide more information on the definition of "more
> > consistent" LSM infrastructure?
>
> We're doing several things. The management of security blobs
> (e.g. inode->i_security) has been moved out of the individual
> modules and into the infrastructure. The use of a u32 secid is
> being replaced with a more general lsm_prop structure, except
> where networking code won't allow it. A good deal of work has
> gone into making the return values of LSM hooks consistent.

Thanks for the information. Unifying per-object memory usage of
different LSMs makes sense. However, I don't think we are limiting
any LSM to only use memory from the lsm_blobs. The LSMs still
have the freedom to use other memory allocators. BPF inode
local storage, just like other BPF maps, is a way to manage
memory. BPF LSM programs have full access to BPF maps. So
I don't think it makes sense to say this BPF map is used by tracing,
so we should not allow LSM to use it.

Does this make sense?
Song

> Some of this was done as part of the direct call change, and some
> in support of LSM stacking. There are also some hardening changes
> that aren't ready for prime-time, but that are in the works.
> There have been concerns about the potential expoitability of the
> LSM infrastructure, and we're serious about addressing those.

