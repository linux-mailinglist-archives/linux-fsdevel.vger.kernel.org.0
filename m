Return-Path: <linux-fsdevel+bounces-4043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0467FBDC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 16:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589F6283193
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED45CD2C;
	Tue, 28 Nov 2023 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp1CRPHZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B665C081;
	Tue, 28 Nov 2023 15:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFC5C433C8;
	Tue, 28 Nov 2023 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701184261;
	bh=A2e4Zu1xuXIH5aOiqDfkKoKHysPswpglpEU1MVS4blw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zp1CRPHZ6pLu8HW2zRDnHBw1nsy1C833JZvVCn7RIIbEnXewZelaBPskrs2PFsvhd
	 5PAAqpyoXGkz/V/AGvHzgl0kyZ59TTJ5Szx0vzB0O2YnESGrUrS+Ic0JIYI59DUGMX
	 WVlNFcwHdVbDBzjCBxNzC7AlVKrVWtoONHg+GJAX6iZ5W53wffUpo9HFdXjWpGdgjt
	 ZoMp+6uqy4P4OR9kkwejo3hRw6XLmh/acJhd+PPRkErTEa8ApQ1CoYIKwzKY7K21Zv
	 XzmKxMP+GLTACFS70YUR50p44huVadO7b/OcdrUNLZqp9DqWtz4hLwSQvas6hMWz0+
	 NIub70NUcgwkQ==
Date: Tue, 28 Nov 2023 16:10:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	ebiggers@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, casey@schaufler-ca.com, amir73il@gmail.com,
	kpsingh@kernel.org, roberto.sassu@huawei.com
Subject: Re: [PATCH v13 bpf-next 1/6] bpf: Add kfunc bpf_get_file_xattr
Message-ID: <20231128-einfiel-eichenbaum-6c66745f9f74@brauner>
References: <20231123233936.3079687-1-song@kernel.org>
 <20231123233936.3079687-2-song@kernel.org>
 <20231124-heilung-wohnumfeld-6b7797c4d41a@brauner>
 <CAPhsuW7BFzsBv48xgbY4-2xhG1-GazBuQq_pnaUrJqY1q_H27w@mail.gmail.com>
 <20231127-auffiel-wutentbrannt-7b8b3efb09e4@brauner>
 <CAPhsuW4qP=VYhQ8BTOA3WFhu2LW+cjQ0YtdAVcj-kY_3r4yjnA@mail.gmail.com>
 <20231128-hermachen-westen-74b7951e8e38@brauner>
 <CAPhsuW6R-1ZjToupiDtRWjxpcdTA0dw0Sk7zDi9+5AUciTJ6LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW6R-1ZjToupiDtRWjxpcdTA0dw0Sk7zDi9+5AUciTJ6LA@mail.gmail.com>

On Tue, Nov 28, 2023 at 06:19:35AM -0800, Song Liu wrote:
> Hi Christian,
> 
> On Tue, Nov 28, 2023 at 1:13 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Nov 27, 2023 at 10:05:23AM -0800, Song Liu wrote:
> [...]
> > >
> > > Overall, we can technically add xattr_permission() check here. But I
> > > don't think that's the right check for the LSM use case.
> > >
> > > Does this make sense? Did I miss or misunderstand something?
> >
> > If the helper is only callable from an LSM context then this should be
> > fine.
> 
> If everything looks good, would you please give an official Acked-by or
> Reviewed-by?

Yeah looks ok to me,
Acked-by: Christian Brauner <brauner@kernel.org>

