Return-Path: <linux-fsdevel+bounces-10042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B50C84743E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195D21F2D0EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A151474B9;
	Fri,  2 Feb 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2+vWe/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7A148FE8
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890060; cv=none; b=TuL94ZHd5xednGQrTR7AWJDTnjBInmLlpRBDsPWPTYHer0s6sJdEB/o1Nl/fwgT9134YDhmElygLkOa6hAqvAdWGJc3qjT9iXkYXZOnAITWHfH4sUHEExQso/EKkcno+8XixDBuzq6dugoWWlnZrIzrr4nurVSsSOu49pFt/LRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890060; c=relaxed/simple;
	bh=HHi1UxmMH2tHjDjaNU4XCBQu1ROthkPo1wqP31dgE0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qViuhCWifWu0uu345OzfapN6aPJMI35yaAqvXkPpOQ01PYT9U0vgf9QaMQ4usLy3Pvm1zJzgKcCvAc8CPCUvO4bNolE4dOKGKFhsrvtwVl7MqkICcCqaLwgz3btDJrcTWxOEf/wJdpMOTtWabrFWDsxnbJhrFmG90YmzG6ah1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2+vWe/L; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7810827e54eso145412985a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706890057; x=1707494857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHi1UxmMH2tHjDjaNU4XCBQu1ROthkPo1wqP31dgE0k=;
        b=m2+vWe/L7RpW3bjG6ge+teukhbzZOpnBwFJaxNtZn9bN7LVSGOkYqbWFCTrol/SazB
         aQnzm92vaprJN9FiQzo4IRxQkuolR6fMxDRpxiYVjlwVhgIWjNR9HwOrdHxI1S8wlBdU
         Psb2pgycw1wtfqE7l6xVoE1TniEWJagcwcBHoSUXNgTjnA0o5IvCtJgk94psNb9a30Vn
         iaFNJh9cdOlSad9yuo9/dC92KJOxyIuOD64UJfslB5+aO+J7PncL8+nrJ79aQjGFnN38
         G5Ys+pnLDEj+wk4W/rJ+DMVzgGVM4IjM0SHl5kN8ya2f1i8dGEuxnohGAIyC+DPzwdIy
         3KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706890057; x=1707494857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHi1UxmMH2tHjDjaNU4XCBQu1ROthkPo1wqP31dgE0k=;
        b=eCFHPof4G0xTDJMXb0P5aEfCNDXV77nNUIrQ/Txpcj9xy7EIpOhRe3xSIV3c+cIgP0
         gCdLpARwrcf8Wf6mGcesR7/YxvF05BLPVuatirBmk+Q6Mds7ssVnsXEdFBAQN9UuJzm3
         aZrvfEdYE5e1+1hd6P5eMLtbYHS2nKknrUW44vJ6C0QWGtrAreC6xqFH1cum2AsgKgOc
         o/X6q+krKow9Nsz/x+wofxv++h4UhWNBnkUEauSifcDwdP0brZrkffIU4ghRF90LOfiO
         ksEkaNu0XgK8vLoBmRGPW4v1NRViZzW/0HWaWKRwzBwq/4y7Ol/uHhxwvGx7PF6gX7YG
         4ZUw==
X-Gm-Message-State: AOJu0YyVu7nY8Xm/yAQwO8n4WQVUl6yNhU1ZRZVdtYsbIZplQegOtYHj
	TdpyXKQnQc9uvOZdme3soar+ZB63WsbxrYs80V+NNr7Rc6IBwdfD1W2Gd69Gdy1479BJI58AeB2
	87RtCyPcsREYGyIM0/w9f0EmxOA4=
X-Google-Smtp-Source: AGHT+IHuwcHiNFB5kBQtnVoZkeWaCqE0RMcPwxYQCiWK4O4Pgzdy08kvzTbpaS9vzRfbqwolSxXh7n5l4FU3NIsdRzA=
X-Received: by 2002:a05:6214:b6b:b0:686:a20c:faf with SMTP id
 ey11-20020a0562140b6b00b00686a20c0fafmr2687054qvb.12.1706890057538; Fri, 02
 Feb 2024 08:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-5-bschubert@ddn.com>
 <CAJfpeguYDpLN9xPycd7UMwJfp-mctc38e4KFr2v_CvPSDayxEQ@mail.gmail.com>
In-Reply-To: <CAJfpeguYDpLN9xPycd7UMwJfp-mctc38e4KFr2v_CvPSDayxEQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 2 Feb 2024 18:07:26 +0200
Message-ID: <CAOQ4uxgvJ_BPKo2oLJo4XuZnZnk0t1p_phhdVfb-vE6JzCqePQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fuse: prepare for failing open response
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:55=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Thu, 1 Feb 2024 at 00:09, Bernd Schubert <bschubert@ddn.com> wrote:
> >
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > In preparation for inode io modes, a server open response could fail
> > due to conflicting inode io modes.
> >
> > Allow returning an error from fuse_finish_open() and handle the error i=
n
> > the callers. fuse_dir_open() can now call fuse_sync_release(), so handl=
e
> > the isdir case correctly.
>
> Another question: will fuse_finish_open() fail for any reason other
> than due to an interrupted wait?
>

Yes. Definitely. With fuse passthrough.
Wait for parallel dio is Benrd's share of the patch set.
My interest was always to deny cached open and passthrough
open of the same inode and passthrough file open to a conflicting backing f=
ile
as we have agreed [1]. See this passthough open commit for example:

https://github.com/amir73il/linux/commit/9422b02931ca4be5471230645a2b4a6723=
f99d0e

I will also split fuse_finish_dir_open() as you suggested.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAJfpegsoHtp_VthZRGfcoBREZ0pveb4w=
YYiKVEnCxaTgGEaeWw@mail.gmail.com/

