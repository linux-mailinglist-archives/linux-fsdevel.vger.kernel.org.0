Return-Path: <linux-fsdevel+bounces-22656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F7F91AE04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AEF283F2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF819A2AB;
	Thu, 27 Jun 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FKtqapJ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098519A2A8
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509092; cv=none; b=W2PwS1/+lw52nRzPuheiOiubXwt2XwhBj+WfM9wvygEV4mjoxPEvX/QZvFZF43RDAqw9Sz8XUF5wrgU0xWpUEk/Ov9ahQMZDNBTgULo9n9smeUWmX8RbyjIRaf4Dc4j/WMmJ54Z+Sp6wWzQsLqKo2pym7DtT3ljjAkVE3bPz5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509092; c=relaxed/simple;
	bh=22xwwUTqczocNceb1LCntFNHntuWQBjour6Xg+b/U9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3frhT4V8/OJpOHz3gpvq5hsdonF9OkHXHEFmKGjUSJCq3BPmxNu3aUIEMDjHdto/LtkvqOiKYE96SgnlfcEFvXbTck+TsBCMGtL0G58P4Y+XCw41Xmu41HjNbZSvvseeMntyJOvK1d4LY6nRr8yMupy+RuG99GWMRvs4CBusSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=FKtqapJ8; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79d55fe9097so105549885a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719509089; x=1720113889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iWlw171IOeLPrAeCPo5BJQh0CIfJcfMAWaSYaHx6VN8=;
        b=FKtqapJ88TZsJJfL1Iyn7mRdyHXpdCVIhzCiOenDSM8wsOIZCqCMAVMhD/PrT1cXvU
         GH+pga7XApb9UKdrqF80RIoKNBurQMREyEdZVMY9Cwcp/7qngxbJTLMACNfwqaMpIqSL
         4FQMfiH8gfRCJcsgRhbxq/HE+5FtLsbxDoBMgo/p7aeKz7ZK21DQAybJ+nslGpLdirT+
         l7gD/eIA5bIWk9X+FbfMCdoirqJzlTAdEfdd5oNdGvADu0U9ffXG6iWIsKl73EVLRjIh
         lfJS4BIKY0xAP24VrVWetGx611+w9QzWW8rPuFx1tP7SqsJlCZm+ilOC2K6RMifMczhk
         iMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509089; x=1720113889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWlw171IOeLPrAeCPo5BJQh0CIfJcfMAWaSYaHx6VN8=;
        b=bnntttYe7XjdNQuem0LDiR4mFL2+sZtXLTannRzoniNqfzRXnAFs6HXrO3/CUR8KY8
         Zy8JCZWIo3uswQNXXdawCB/6lyOSrO5Shp4b40Eiu44+fNSWsa+EvXUnhpopqeNwioDv
         dDCLvfuTWvfSeOtcfyGj1bIAkiaa7HU0W+4bgjjQKXCL70xOs0NvwzMR3am7zmrMcOOq
         w71lnwEBi8huVX/CcLGapRTBp0A9de9jxIQ8LVPv3q+aveHwlCGDoA05i1oa0lEzQiXw
         u4ZcagK0S19NonpYWToOkZqfmMjCygsWTwW71efXumvZOZ2a5laDuNApTYjBnWHY8jqE
         M22A==
X-Gm-Message-State: AOJu0YxgpBkEF1M7E4Y9lgrLrZgbJM6G5AVn4JrAPRiAaL5k8IF6nVax
	poxoH5NLbOB+BCn1RNW2a+JXiveikOo3wOLcoDn+p3aDqfDQRqNxOB+MKONDtJcTKtzxvX+v8Rb
	D
X-Google-Smtp-Source: AGHT+IGujTPPKYS8vgSJH6YMjDwhOXzkb26+kV64PBanLs+iiAZ8OWVEMtI9rHGXbN4NOEnfWU7YsQ==
X-Received: by 2002:a05:620a:25c8:b0:79b:ff3c:7955 with SMTP id af79cd13be357-79bff3c799dmr995506785a.53.1719509089421;
        Thu, 27 Jun 2024 10:24:49 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c8bb3adsm73455685a.117.2024.06.27.10.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:24:49 -0700 (PDT)
Date: Thu, 27 Jun 2024 13:24:48 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
	Stephane Graber <stgraber@stgraber.org>,
	Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH RFC 1/4] file: add take_fd() cleanup helper
Message-ID: <20240627172448.GA4050905@perftesting>
References: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
 <20240627-work-pidfs-v1-1-7e9ab6cc3bb1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-work-pidfs-v1-1-7e9ab6cc3bb1@kernel.org>

On Thu, Jun 27, 2024 at 04:11:39PM +0200, Christian Brauner wrote:
> Add a helper that returns the file descriptor and ensures that the old
> variable contains a negative value. This makes it easy to rely on
> CLASS(get_unused_fd).
> 

Can we get an extra bit of explanation here, because I had to go read a bunch of
code to figure out what exactly was happening here.  Something like

This makes it easy to rely on CLASS(get_unused_fd) for success, as the fd will
be returned and the cleanup will not occur.

Or something like this.  Some of us are dumb and have a hard time with these new
cleanup uses.  Thanks,

Josef

