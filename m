Return-Path: <linux-fsdevel+bounces-52816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A43FAE7209
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 00:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6565617F26C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 22:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B679025B1C4;
	Tue, 24 Jun 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNI+M36G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8A3D994;
	Tue, 24 Jun 2025 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802540; cv=none; b=Z3dU1uN4W5Wvu44DGPdJs+Tb+gDRJpMtY/NIjEvFnJJ9mWj9oPmOjsoK/Lkreii5ddDwPdurYZgFEf3P7hOZWCC7sAspxu1KRuACpopjYcXv+5mavRlLhde0DylihY4Y5yq3Y1aeM6sL2ayBX95XzlP7fFy0uYB+Hyre3wjL8kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802540; c=relaxed/simple;
	bh=KI6/XmV9em9yxZDWFEWy5ZAZI3Im1BUdkLJpbjnspMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFbAM2Tsd6McVMYxaZaskTSA1zt+QM+KSg5aOK9blb0BUpvEK/24sbskGEoaXCiEBTwIz+X5acH6AKHF/YqpQ4llm3HLfz7KGA17DqCEekN3g9EWURrZaiyS3qibUbklR6+CQEiOThphg29MvT8eL4BGM9alP/gY9BZS0zLpN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNI+M36G; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a77ffcb795so9797471cf.0;
        Tue, 24 Jun 2025 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750802537; x=1751407337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI6/XmV9em9yxZDWFEWy5ZAZI3Im1BUdkLJpbjnspMQ=;
        b=TNI+M36Gs8zglTD5I9LsSpIvuD3R9HJ9LCbnDoN/xXw5kveum65x02BmxD8OA1h7NI
         PUfziYy+2ZQ8OG1CmXGEcvkhaeaOSuthWBSML/ZrBfvCQRFtLM/EaSnSmVP8uth9eGee
         R3YNzRN0CpBQD93pcE0HmK2Nt/gaWtEU3pMo5tfaBb/0xlsXI2KUJeeEnK5S1MKB0QHK
         AGBLdH1YofBmvzgI7CUVMYXyUiB86C/lWFDjcxr+q2D4GDF6tG9xI2PhvWiEfKaKM1/U
         K0Rw/5X97MiwETBYj7UCC7NRATGVcjUNDR+WfA5FWgwitakIe0LvCHRjpoR6QvRO4Yui
         sJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750802537; x=1751407337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KI6/XmV9em9yxZDWFEWy5ZAZI3Im1BUdkLJpbjnspMQ=;
        b=ql/fhVn0TB/vorlZOFKZFQ+jIRxD8/uHfE+AIPJNbiDrdpzHjoC/m8iAPE1k/Ebe9/
         XutmRtANF3ZXBAk2dpCHGr1pIIRUA2TgdN/A+EiTSMPj/lErWsRGUbOFP5x5qU9WKiJu
         jyCAbYVFGR/7Z02KQLqTV7psKHjNcqAm3MV7S10mjGQWpw6qdl9dhypmvOEG0csjkrNz
         OsRU6hAsIGCdR7mt7DH+c3jecsBlL9GwsW5mSmPdiw92aMpe1OMMb8nq42qMzg/ceSrP
         Z4+9L4t9UELnSOdMwEDn3GMtLu8psxXe6bQReikBkh8eAZ3ur0snTqiDh1yxv9g8SKXE
         k9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDHxNVsYVEda0efp/NOyw+P7Y41jeKMF7RVH5eplQbasvMI05oNcObFtfNqQbOO6k5X1sExjoD7zjh@vger.kernel.org, AJvYcCWElo9D1ERKm7zkCGn9MmYAgw6VBTZ26PydtVpKcj9tij6q5iOONj115J99E087AEVxkctFchRqJP6U@vger.kernel.org, AJvYcCWiz1Et8kdjatXWkNL8mECuUp2+SPBjEeBMCniEltgBqqwLeJvARXTd7XN1XYtZnhEspmsC8i9ib2FAKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQmsyK4dTd9ggbLTh8UqgtNyCOZRUU3KTzs0pvcHqgsbvIayR
	ESP1nrvPvjENZNhH2OlQkjXU7pciKSp0JJCC5yTNx4bxG1QD51F2Nmg869RPinszDlEqTsEw1/T
	zU94qbY3VAkARVDoRdYDB4r9oJ/Yz+e8=
X-Gm-Gg: ASbGncv/1Tj81C8vtu/AePjHt1838vRe+VQUEigL1D14zgbYA8/R0sQrb5nn0oH3Jvx
	au5Wz7hM6Kjf40uxdcD25mSplCE53JVPUjEgd9iTTkrcTHVJEkaLNWRvX3aDhpl7xHoZSbAdykl
	puKMbNWU0rBuGv4QMdMyQ0GX5+Yb1wkWoor6Xp9x+sUkk4qrabMiFrUDXGdV0=
X-Google-Smtp-Source: AGHT+IFApJK8qgHNiP15oAq3BEZlkrbkeLkCUqnNVjpYJuoZ4/jjmxsvBbUNxUSjqZ9kQuVJI4zok8KgKMGPbchiCDI=
X-Received: by 2002:ac8:5905:0:b0:494:adff:7fe2 with SMTP id
 d75a77b69052e-4a7c0bbd8c8mr16752751cf.43.1750802537276; Tue, 24 Jun 2025
 15:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-2-joannelkoong@gmail.com> <783b0f0c-e39c-4f52-90e9-7f7e444d9e84@wdc.com>
In-Reply-To: <783b0f0c-e39c-4f52-90e9-7f7e444d9e84@wdc.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Jun 2025 15:02:06 -0700
X-Gm-Features: AX0GCFsv1OYMTj4vzKRiFaHM3oOY5EQaLukCgNj950jARV6_mnnMOsZzOQUOErY
Message-ID: <CAJnrk1ZQ=wVKmoQS12ixQHDuynMZNEkcu+Z0TgLvXxXRx++eEA@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] iomap: pass more arguments using struct iomap_writepage_ctx
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, hch <hch@lst.de>, 
	"miklos@szeredi.hu" <miklos@szeredi.hu>, "brauner@kernel.org" <brauner@kernel.org>, 
	"djwong@kernel.org" <djwong@kernel.org>, "anuj20.g@samsung.com" <anuj20.g@samsung.com>, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "gfs2@lists.linux.dev" <gfs2@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 11:07=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 24.06.25 04:23, Joanne Koong wrote:
> > From: Christoph Hellwig <hch@lst.de>
> >
> > Add inode and wpc fields to pass the inode and writeback context that
> > are needed in the entire writeback call chain, and let the callers
> > initialize all fields in the writeback context before calling
> > iomap_writepages to simplify the argument passing.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> Looks good,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> But IIRC it should also have Joanne's S-o-B as she's carrying it in her
> tree.

Hi Johannes,

I'll fix this up in v4 to include a signed-off-by line.

Thanks,
Joanne

