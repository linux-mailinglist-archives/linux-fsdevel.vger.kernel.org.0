Return-Path: <linux-fsdevel+bounces-69627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE13BC7F03C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 07:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82EBD345DC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 06:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294012D0C64;
	Mon, 24 Nov 2025 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsI5Eq7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C65221F39
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763964359; cv=none; b=ZSNA48zTDOFRLOl6BftHfCUBTQxLumnEjmUxlvgnj0bFTRYzhnExMYLperQWN9yv3ZkZ5VosAVpE7aBGGVze+k5XKYyG3ExTRxREsSUO6zT3ow0BLYdpKJ7lvQ7SakXOmvFuvXCQBcM13wvh+eiLbEEgGNdTr37SCZHjo6rK1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763964359; c=relaxed/simple;
	bh=2CbeR8ntenQ/udtVhShMbURQAzej9vCJiC0LEn5ddxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMpAJTh9oGEDPFby+JPq5qQy/OoC+sGxlJFYWEQ2D0roy3AfcdmA054ipB3A7hlYXgYn3CIvYHWwlW/cBO1/Wn02rS8I2MncPT92Z5sUeC53vdHW60jbXZKWXQcjoyD74duwEjSY/H66wGELQD/Zj9mx8jejKbIpg5dLLmdJCmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bsI5Eq7W; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b566859ecso3473856f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 22:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763964356; x=1764569156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZqOLfNt4NNjM4szCLBdWh2M6zRj7620Z1ksv8HS62c=;
        b=bsI5Eq7WM5o1MsHflC2TU+27GoNjGqfn0Eon/PYJCuPpTIZ0SnJadfXFw5+ecFqxFo
         lzEdbaXh4/SMIUxxyKRqnW02RLlrS7u4i3GgxTqFYB+f++jS8r0n0nMHpA2RzzT1J0Qq
         mHtANDl93/eAjZbovv8E07DKM8T6VtE+2Z2pX86cWNw/DmicO+etSkVntzJ1vSlPq/y0
         HQ1qkKcPvygHyShiT7kPbmeyBRe2IVcqpLPFl8CpH4ZETB1jkVEkI3I0pKoh3nDOwT/5
         htUJ3GFB42+SvhWNmw1tRWejCaPFhal3CgSwj/AhO51YJ0k+avBcSmSzfQvEfe/cuFG0
         jFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763964356; x=1764569156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZqOLfNt4NNjM4szCLBdWh2M6zRj7620Z1ksv8HS62c=;
        b=khgPr8Rh6guHYq8HGMF+Gi7PG0FNof+pr2E6vw7mduohT9+NbV4aPGWgf1GU4VMgPd
         kRo26K3URLPotQA2aQ7cEgeA3euU3eaXD6KXLD0xTaVry0G6OKqAGH5/Z2zzzS3sKqEA
         zb8X30bmVYHBPzS/LgoLlbSc5nC5P5rjQM/LYSt0UPvm3k4hOCZfurl9exHZ8RAhqhp6
         l8WkhXWLzxdL04I6/QYhVEuHWY1+dyWNr2s9hQoBNTLFgxdcBa3qPbTqARQS/Kn1m7ix
         oqVpmt4mYnbbUH4Gqz3dSWSc0gSKvx0/XUEq4Is6KEgFp9b42Ijm8Cbqcl82GNxrsfAl
         BqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0l3kTDc5ry0MNFCyMkIDRm8HgvzbTP89kFMA/4CPvzbVA6rSVRW1kLVYS69niXrFvX0emCANPJJUey1KW@vger.kernel.org
X-Gm-Message-State: AOJu0YxWO/fkizRbmePCdD8A6hBiR8GE61Dl4GrhR/0c8tl4oZClyGCB
	61sBFf/qrE9cRGkWzlpVgYBPZXVgshnKiXgUyvGMCVAlxXh+J/XETDX4PWbKtz3nmQ0=
X-Gm-Gg: ASbGnct8SAfdWxosY9sm2S+O5opAIL4FIONeAhnmZrSA/8mAeDd/IhhyJl+84nTYiaE
	xtXb2UEVdifNoAY+3FBpRY51smc54Cf9cVUN67kIkh2qh5ih3IOfeksjT3sRU654J4V/NK8X+LK
	GSuMM5bCW0r4S2SwlWZugCOW/fMoZHlJ9izwYmT/cZSqjtyGYM9FiL/XJY9dRDWt/qz7r/2OiA1
	3E8rnQnwIQREcmmaaOP/H8daig0+Gq4QK0xu4ygGddOepUpAbTdDBffnXtJEM0VJsdW44W8j9F+
	vS7CypejkNbkcWpOk/MHwwbtP3YL97rs2wkIn6KaailmxojwEv/pjQfjxwTdDj+XoX/DqgQQAAT
	fUxixAth0QMx2OH2uWxztz1Ks2rgOF+Nj3/x/O5+WvTMR7clUzBOnP24XSJCbyDbRlrHY9Dwsmr
	b2Db87tt60tzcQlBMOrmNKl1DyEK8=
X-Google-Smtp-Source: AGHT+IFTj6UXP07vA5yQa/8SUGDxXg+ZGMMepdyy1bTa4eJm35XddA65LTq5vpooyvG9kjtwauYocg==
X-Received: by 2002:a5d:5e01:0:b0:425:742e:7823 with SMTP id ffacd0b85a97d-42cc1ac9401mr11186194f8f.12.1763964356070;
        Sun, 23 Nov 2025 22:05:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42cb7fa35c2sm25166281f8f.25.2025.11.23.22.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 22:05:55 -0800 (PST)
Date: Mon, 24 Nov 2025 09:05:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] fuse: Uninitialized variable in fuse_epoch_work()
Message-ID: <aSP1qs4SOHrDE0tO@stanley.mountain>
References: <aSBqUPeT2JCLDsGk@stanley.mountain>
 <873467mqz7.fsf@wotan.olymp>
 <aSCkt-DZR7A8U1y7@stanley.mountain>
 <87ms4ez7q4.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ms4ez7q4.fsf@wotan.olymp>

On Sat, Nov 22, 2025 at 10:23:31AM +0000, Luis Henriques wrote:
> On Fri, Nov 21 2025, Dan Carpenter wrote:
> 
> > On Fri, Nov 21, 2025 at 01:53:48PM +0000, Luis Henriques wrote:
> >> On Fri, Nov 21 2025, Dan Carpenter wrote:
> >> 
> >> > The "fm" pointer is either valid or uninitialized so checking for NULL
> >> > doesn't work.  Check the "inode" pointer instead.
> >> 
> >> Hmm?  Why do you say 'fm' isn't initialised?  That's what fuse_ilookup()
> >> is doing, isn't it?
> >> 
> >
> > I just checked again on linux-next.  fuse_ilookup() only initializes
> > *fm on the success path.  It's either uninitialized or valid.
> 
> Yikes! You're absolutely right, I'm sorry for replying without checking.
> 
> Feel free to add my
> 
> Reviewed-by: Luis Henriques <luis@igalia.com>
> 
> Although I guess you're patch could also move the iput():
> 

Yeah.  Good point.  It's cleaner that way.  I've sent a v2.

regards,
dan carpenter


