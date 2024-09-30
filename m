Return-Path: <linux-fsdevel+bounces-30396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199B98ABBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 20:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D147E1F234EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3145E1991D3;
	Mon, 30 Sep 2024 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="umNcedll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6E1991A4
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719984; cv=none; b=AWJOQ7paP73HbWoLD+xbjBTanwZctpqt2IUdm4InlR1KdYAXmnYT0TRi6bmi7vhDk9ssNmNqnDdHzTH2U7M00GM7j/IwDRhZndC/DF661M7/NoSdr19w0sDh4jluUDmGuz/T2Bu7I0Th6ZS1lScfZ9bpyCSWy/ZpCRutjhowffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719984; c=relaxed/simple;
	bh=MwpHU1aOR0WfimfF8hwtKOZhLVLHjAgYuri/pRu+Y2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpS4awmWil1g/rzcARd5vDDq3DV96pwDrflfnuzw/+RgAeAkh1oKKdol9GaJVQwe7YGZwpIVNB8u3C4r1PvIFSX/PO8HSqTU8xnDlMelNzCh0THyyOCcoGRf2NF6HI3Zo+nd6tV8gEDTdTOpAi/Of21K3CkyqCm4WdQBFZ/aihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=umNcedll; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7acdd65fbceso389903285a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727719982; x=1728324782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdALx6XGSg/fJg5fRcCHzFiKUWFcvnMkCefk+ccFZhQ=;
        b=umNcedllilUFuUlvh2MXJ5i8nlY8Xz/Ax8iCBpbHlGMeHdXVWw4YIW/7pDcYrk9RPk
         X7yMBzqmFx/jeQU9akhFJTbZpQzZaSo3DcpdA2nPHu0TgF/EL/cmqh/sYejg2BfeUqpA
         o+Ae4AxyBq0NEDv0j7/KvzU8Tsvs70krJmrKp/jYfAySwNpfS11cf1twofbDsZwUDcqH
         aD2ONGwCqef+jQeNBm+0z7hqvT1D3xd11wc9ogcnsmrLI0ZWYdsS9SgNz5s31HUvwPr+
         vQsI23ndBjVh29iO3vIMJUK1dZoTdFknefWvNlf07iSbIpxMOGB/V9Bw7PE1yKwkplj8
         ds+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719982; x=1728324782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdALx6XGSg/fJg5fRcCHzFiKUWFcvnMkCefk+ccFZhQ=;
        b=NxTrNHCk9NIiU6V9AVxXzsVSwyeoYCgUhu4N0AaAdXROQufJ4OQd1a7flONlz5Uo53
         c1coWy1+ZCkDEJjUgn8y/2SsAhanxT7Qtq9nZBvmms1FhDAxvFNMr1K4aWq64r4I8voe
         CIqA0RuWxjpNNYPczoDbCqGCRFBonSoOZ92+nGbMMhF3OQThT2Tblf/zIXGpGIP8PtJ7
         CC3EjrwI2lTIblVukhmrMb6KLzmr2rXarjnemuF2l6TkxzHUpDhOS9Y+iqCuW/23bEUh
         fcj062dJyk01iwrKLa1xz74DV0MkpDh7s8YFRJXxHMmFkIoqtAhv3MrpfExMfCMy+EMf
         PyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU98sip6u9tdFeWw92WjWEvOF3YZmbSov3Wnx41g4oRij0uaUot8DgH5KwFN2NVp1gzet1x7jQd2Akz4Xtv@vger.kernel.org
X-Gm-Message-State: AOJu0Yztcyus/E8OEbBk1WZUt0xV7xXVWLkq4CDKUqt+hm0MUl0K7EOM
	46GT2l9X7zbSxqyM87guZNPQPg5FT0LSMScV8+qBvTxH1UCp/e+ZlpMyZVpERmPrGbzn9HgGWzA
	v
X-Google-Smtp-Source: AGHT+IFr76puGmRm668E/wAFDh1BfXsEVxvgieZu9NsMRTlQ7+ft2Y8FTRu64vMkd5Dc1ZbuGKR+sA==
X-Received: by 2002:a05:620a:4093:b0:7a1:e2d4:4ff3 with SMTP id af79cd13be357-7ae378259e3mr2428718885a.3.1727719982233;
        Mon, 30 Sep 2024 11:13:02 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f2b6c96sm38192451cf.25.2024.09.30.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:13:01 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:13:00 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pidfs: check for valid pid namespace
Message-ID: <20240930181300.GE667556@perftesting>
References: <20240926-klebt-altgedienten-0415ad4d273c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926-klebt-altgedienten-0415ad4d273c@brauner>

On Thu, Sep 26, 2024 at 06:51:46PM +0200, Christian Brauner wrote:
> When we access a no-current task's pid namespace we need check that the
> task hasn't been reaped in the meantime and it's pid namespace isn't
> accessible anymore.
> 
> The user namespace is fine because it is only released when the last
> reference to struct task_struct is put and exit_creds() is called.
> 
> Fixes: 5b08bd408534 ("pidfs: allow retrieval of namespace file descriptors")
> CC: stable@vger.kernel.org # v6.11
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

