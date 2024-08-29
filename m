Return-Path: <linux-fsdevel+bounces-27822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C2C96455D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4431F28BA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C997519885D;
	Thu, 29 Aug 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QXfutRLZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D719218C90F
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935571; cv=none; b=NusG3OgwK/jZhEQxhl6xD3AUdit4Ee7SPMowsxAGV8HFxrGwB/X3vhR8ukX2eMhULGQPEnUQq1MKOkKhVT95e021ZE/MVa90ihf0aVzAAVX9TeHdIuqLRuKo5zgqoCtWbL3EnIGe2qEp+MrD8xjaOWpjF3nZF+CyiS6JRZm5xv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935571; c=relaxed/simple;
	bh=AgFY0CuJppxazQdPyDFglzw3FHBPTJ3pB1JFaFZV/QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1HtIJLnng7m1quLqiROM4D38MAsV85D/+KX4taTy3SdQP14Bi/XaWw/VryGB2IXgXCXdx9VuoJr1BwjVXLNeXj5LSDtYCCmTSRbtmO9AZeagSk4gT89CeV90ArUfHE2Fm3DcL1u0B2Kq2U+PzABfT6Kge7ypUUa3v1Zo0xweYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QXfutRLZ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4568780a168so1112111cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724935569; x=1725540369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r7JkW1kGW/foMeqY4idmoG+qoBfKoOOnmzhQ4sgndEI=;
        b=QXfutRLZ75HtYhDo1cGFXD1XI2IsHKLvW1ezPLBZHhy7zaEyw+2ILE0xvl+HWgFVrI
         Epc8MMqoYq0Ay+c6t32NnTxDXOH8T3nKtKzrgp9OaGtiuTCzF6hL6AF8Hc69eOvDqgdn
         3gHwo9bTzU8ahGE2c3NZDf9ymZlO1gSahGioS/I7gzTmH4Kx5Ij/FtfTHZYifzum+s+a
         eqy4/1VW4/DZKY9k+n1J9DJXuK5Pk4581iFGPyEGg5EDl45DnMalctqwABQUDVBq1etr
         ZSyMzwnhbyr+NhWXHE2PwnkTaHpYAMUWvSXVP8itoAxts+F7reXzfKNWMme6pzsWS6rV
         EZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935569; x=1725540369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7JkW1kGW/foMeqY4idmoG+qoBfKoOOnmzhQ4sgndEI=;
        b=uyNlQdyI4ndKeXidQr2OtfN/h9WilqEbQfZHi4jST2+nPoI2we9slWV85V/DWc3Au9
         UrZFdMH6/UqEEJotE+MYW0l0kp2pfu1xxHrnmFBHTrzMF9BmRb8V9QW56gaOf2K/WdkU
         b6rxATKIM8M1FpnYM515OZvoFFmeHSzV0Pmt1K1SC6zrR4EY+TZ4FsGA189DC4+1A/Na
         MeL/hujtpMXlkyFsrQgHH3vdffi0lmHK1Ks9PeFxCpAHEzkAo8ejxRQW9vg4q6eKmfta
         HTiAAiu6ZejfStp2ANuwpHlomHxgt/1Fugkj/hEYI1dFEU92+5lnf1T6/p0I49MODmKG
         OgHw==
X-Forwarded-Encrypted: i=1; AJvYcCXOPrF+Y6R7D+49rZLxDRX5Q2iXlxnh5AKWUJQ74R61gpYPbrnBa0wCs6aRrZRwCOiaV7c48IHRcW6BvLL1@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfzyI49iYro5A03T7ODHX6RdIlxpocy0dK9K0kuwxM2SiGuK5
	486EmOyf3a3E+3ztebj9nd+Bnu9LjTxB0Ayde2Tk8lcZAVeM6S6r5GhPf6psB3Q=
X-Google-Smtp-Source: AGHT+IEjg71/rsVeutV6nh+K7FzjMZMNrg7qdXnGqs9sjXtDgQQ0paOoCdMyiPmGsrXRfVqUngI+Xw==
X-Received: by 2002:a05:622a:5585:b0:44f:fef0:70c7 with SMTP id d75a77b69052e-4567f710518mr29246131cf.44.1724935568801;
        Thu, 29 Aug 2024 05:46:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c98196sm4526271cf.31.2024.08.29.05.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:46:08 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:46:07 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jan Kara <jack@suse.cz>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 14/16] bcachefs: add pre-content fsnotify hook to fault
Message-ID: <20240829124607.GC2995802@perftesting>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <9627e80117638745c2f4341eb8ac94f63ea9acee.1723670362.git.josef@toxicpanda.com>
 <20240829111055.hyc4eke7a5e26z7r@quack3>
 <zzlv7xb76hkojmilxsvrsrhsh7yzglvrwofxcavjo4nluhjbdu@cl2c4iscmfg2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zzlv7xb76hkojmilxsvrsrhsh7yzglvrwofxcavjo4nluhjbdu@cl2c4iscmfg2>

On Thu, Aug 29, 2024 at 07:26:42AM -0400, Kent Overstreet wrote:
> On Thu, Aug 29, 2024 at 01:10:55PM GMT, Jan Kara wrote:
> > On Wed 14-08-24 17:25:32, Josef Bacik wrote:
> > > bcachefs has its own locking around filemap_fault, so we have to make
> > > sure we do the fsnotify hook before the locking.  Add the check to emit
> > > the event before the locking and return VM_FAULT_RETRY to retrigger the
> > > fault once the event has been emitted.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > Looks good to me. Would be nice to get ack from bcachefs guys. Kent?
> 
> I said I wanted the bcachefs side tested, and offered Josef CI access
> for that - still waiting to hear from him.

My bad I thought I had responded.  I tested bcachefs, xfs, ext4, and btrfs with
my tests.  I'll get those turned into fstests today/tomorrow.  Thanks,

Josef

