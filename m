Return-Path: <linux-fsdevel+bounces-26694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB495B119
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54223B22DA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFA6176FCF;
	Thu, 22 Aug 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CR6WfDSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F2C1CF8B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317442; cv=none; b=NQXBYZ1soBiSUQ5wotctD22KAt/E5vqR6ziWWhFtqwvV3jN8oADyzJ5IaGbDjxLI59qJCBc5f5GAC4JaSuZBgJElWk1C9g8baVMEfy3dCcfHHtb9T1btrtcjI+1KNKkDWS1VmDkRGJZ+f6q1BK7ZrZn59N3iVQNv3KetSzAZSGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317442; c=relaxed/simple;
	bh=WGsmT5yG8KfGc8lXCZE3eqZaxeSy5+5v445gCnaNG6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYG/tY6fO43LEdPmSgLtzCn6k7gpWtX733sFWh2NsQbShrdH2XjjSpmBsAu8FNb97fEqYfo25+WYMAP8vTxsgxt2wNT9zBb/bNiJppefSEXEO2hOwG3DQDy/P14S+NcPBqx+LYygxRMxiL4GX09XH8PEYLxpgyh39GYo4rBmL4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CR6WfDSt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a80eab3945eso66162166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724317439; x=1724922239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gI84aCclaeibpm9anqEy2KdYXJmlApfwpyGCN+q4y+Y=;
        b=CR6WfDStFlZ/ODcbHpggyDPtQHYUwaXWFGN3ittyJTCTN0gLsWoJp1FvGgYY9mRTxb
         etxQq9Uxdppy6WbGengUOz2lMDL+D0+cLxozrp3FnTbzvzwvN3fhEt9n2uAImXcLCBFh
         OuGT9Eyn2KKk7dLMDJ3oN1FmhlqeG07rexUv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724317439; x=1724922239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gI84aCclaeibpm9anqEy2KdYXJmlApfwpyGCN+q4y+Y=;
        b=A7vQcgIx7tokcjmlDj8q2nDfckXqG75IZa11x7Uq37R0jeR7odLBpCNkZoqKIx+lrO
         7g4z8n8LPebYyIznNZ1kFcXt6WHBmaX/+CIt7QoFSpl3FQTIt30gjrNXD4MzJjjpzIv5
         Fdy/rjEAZ73Yk0RLt516ZPxzEsWOBgwxBPXpKCJIslsqMKSfA6m3oIo9+ZPzoFZ5kb13
         92pz3kVu7/Lzwqse0JHpzypFPY1iUrNWd+IoALHbqVBgweJy9ErW33j6oUpdGp2vWowZ
         BVb1yMcOXMc2+jo6FOIiXq946iz/YybYdw9INcXdnYliIxhG8ar1KS4Pfg0mkXnK/6Yp
         nSLA==
X-Gm-Message-State: AOJu0Yw7KIOLmAA97W19SBrnyFOa6/bNqSL63J6wzXpzX13Sv+TUB4tH
	jgE0atHYQruRrqq0Ha6mU1OKR/4dGjXQP0kc1IQ1auh0H82J2TplypQDRiPzq6afdbvfyEdM9xn
	LHwyzsQMsFEdy0acgaA+0eJd2e07ZT6fsdGL95A==
X-Google-Smtp-Source: AGHT+IE9JUctXZ0Kcu9S9XLPcCPttac+GIBpRdjJoc1SHbk0+O7FjZvsxWK8QpySIak6efQLfFGijItewObtp2jlHw0=
X-Received: by 2002:a17:907:971e:b0:a86:99e9:ffa5 with SMTP id
 a640c23a62f3a-a8699ea29b8mr7235066b.34.1724317439259; Thu, 22 Aug 2024
 02:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821232241.3573997-1-joannelkoong@gmail.com>
In-Reply-To: <20240821232241.3573997-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 11:03:47 +0200
Message-ID: <CAJfpegtYunMbKMHz1JMrCUttN9UEsVAp+9f+x0rvUx281WpjvA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] fuse: writeback clean up / refactoring
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 01:25, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> This patchset contains some minor clean up / refactoring for the fuse
> writeback code.
>
> As a sanity check, I ran fio to check against crashes -
> ./libfuse/build/example/passthrough_ll -o cache=always -o writeback -o source=~/fstests ~/tmp_mount
> fio --name=test --ioengine=psync --iodepth=1 --rw=randwrite --bs=1M --direct=0 --size=2G --numjobs=2 --directory=/home/user/tmp_mount

Please also run fsx  (originally fsx-linux) from the xfstest suite
which stresses the I/O subsystem very well.

Thanks,
Miklos

