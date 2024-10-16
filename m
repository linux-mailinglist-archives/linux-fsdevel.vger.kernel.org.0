Return-Path: <linux-fsdevel+bounces-32084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 751209A063B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 11:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69C81C22DB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8832F20604C;
	Wed, 16 Oct 2024 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DZ+n8Ss/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3339920605A
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072649; cv=none; b=sEBszrZjkduyie2jmVuUwMu1sEYzkF+44UZLQ64XJXJng6smtpwkpBD8m+VNBjI2S+BTmyJbQ7/8aK7W7TOgktuFqBcCXRXgTNP85XiUD50Ncw+GdO0ZQ1GYY7qjuqOdb+8Y3GXnnr8VANHgWgjj1+3SrFjIFSKpoIuBbJ6vv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072649; c=relaxed/simple;
	bh=NrwsaLZFCcnjWXaG7zZyn3R+sgxp1Utnwi+JaN/llmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDMaRejk+mne42blxzucKUgHGC1F3VD4CQYXJpOjZJZ1XqEfljDUT81j4N99+atvhKaGvyqyDhS4KQJMeSi2VxfjGF4nIwIZj5VldQfWDokCnd0u/KBQKEK2jr2MIfW9K2zKoiHun6RqwbwaF6QtZ9BtTeZdWy4oEWH+HpnXzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DZ+n8Ss/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so8077023a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 02:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729072645; x=1729677445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JfC93d1ozMDiTxm8vjdjbgbssossFxoTzO6/DvPfxb4=;
        b=DZ+n8Ss/NzCnwfY9KR22NGuXLsr1F46Awbg+p6YBKVA2GKH0k8aJ4XGjM19fUIQFDx
         lo9NzjqsG7msr6tErvLhka3C+IQf06AYwDtVaqYQsjNvZdEl1o/I5msqBPYFEuZaq6kn
         N5XdqNMkavsu1GqnvaU8yIFERRt9dF/CwTY9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072645; x=1729677445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JfC93d1ozMDiTxm8vjdjbgbssossFxoTzO6/DvPfxb4=;
        b=BNQJs6L49ABUA9xx/3nh+Sd6B0eSITun5pm9dFt4WXbqDLwxfcEz9IbWKQC3i40tap
         NBoDVEyuBI/daWYMXWPVh4mCpx8miVE9V5E65yTO1F2q+5ccO0oKU6c0whHcHYHfOMNa
         5Q4cmcmb6+Z1SB590V4MKlMBaSis9wejqG3rU2IfwWofO2OVb98olSDIEHRInvWIUEIK
         VxuYNxwqgkPbKF027Dab81EtoGjy/dq+PXYSwDef4+Xi7ThLm+hk3lTONIPrgTpWhCP3
         56kxGR4d+I4r5dDaji2oLJwpKjNNRlkde1sr5rUe8tOdcf1SJ73FLVAcL1ub2oJUznEG
         HuPg==
X-Forwarded-Encrypted: i=1; AJvYcCX0mvCfq4tMBKieDyBw0frNJKPcquSdwje05NkMobRQWQLnvXwk+O1Bsmp7eVcLhgr6jHHjjDOsjFTizfRp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3swvbHoHbWvdT02rxLyQX1HzSURhHT9yGdoUAXdNIKKJ62VV6
	3XF8Phy4AhSA7YyVTh1HXZMQE1tTDNdnKROB0tvPBSRwFd4geqsMV21HvnYSWadUxhOXZrX2EjS
	E7HW72iitPFFsqibCsM20hkVd2wVdIum9/ZetqA==
X-Google-Smtp-Source: AGHT+IFD205o5cMcvw5Nj7smIBJJMKEu1Oxv1kEPmCfsEOHPfhLmvUEi2HjlHyC1nia+stutX/MIAwnjz+OlNkLmsHY=
X-Received: by 2002:a17:907:f750:b0:a99:f56e:ce40 with SMTP id
 a640c23a62f3a-a9a34eba439mr289660966b.47.1729072645430; Wed, 16 Oct 2024
 02:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn> <8eec0912-7a6c-4387-b9be-6718f438a111@linux.alibaba.com>
In-Reply-To: <8eec0912-7a6c-4387-b9be-6718f438a111@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 16 Oct 2024 11:57:13 +0200
Message-ID: <CAJfpegv_Dyx_6+A2dgUuO7TA8nR+AUExCdFA6wKjm6xVYvyMGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Oct 2024 at 11:44, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> 1) a non-malicious fuse daemon wants to allocate some memory when
> processing a fuse request, which in turn leads to memory reclaim and
> thus waiting on the writeback of fuse dirty pages - a deadlock here.
> This is reasonable and also the target scenario that this series wants
> to fix.
>
> 2) a malicious fuse daemon refuses to process any request; or a buggy or
> not well-written fuse daemon as you described, e.g. may call sync(2)
> itself or access page cache backed by itself, then
>   2.1) any unrelated user process attempting to initiate a sync(2)
> itself, will hang there.  This scenario is also unexpected and shall be
> fixed.

Exactly.

We only care about

 - properly written server not deadlocking

 - buggy or malicious server not denying service to unrelated tasks,
where unrelated means it would not otherwise be able to access the
fuse mount. Typically this separation is done with a user namespace or
-oallow_other.

Thanks,
Miklos


>   2.2) any direct user of fuse filesystem (e.g. access files backed by
> fuse filesystem) will hang in this case.  IMHO this is expected, and the
> impact is affordable as it is controlled within certain range (the
> direct user of the fs).
>
> --
> Thanks,
> Jingbo

