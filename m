Return-Path: <linux-fsdevel+bounces-26134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB65954D99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 17:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CD72833E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FF11BD034;
	Fri, 16 Aug 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZB92LjnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8844413CF86
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821897; cv=none; b=eJ+oWQ5sAhl0LJk8Dh1Q7tgPvIxouBORs2elRbXgc3Z1qcljqoOZWR9QLOKJsWlBCem8Rx3hM4YAf+2rf0GO39Cfx9o1l2pHz89QI/Q5qvI93v3BYnL0y3fR/REoVDeyWub6kdxFz+ZxInL+C1WwZyX08LnrxSl1iqwh6leBclQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821897; c=relaxed/simple;
	bh=UL12sWs8tNQMMWLPV43UgqCmeXSMBu86FNVq3NaCk44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlSxXhASGANuGa1wLl5ZhOnVNwF9pHYNdadnxUJLDYfrzI2P3k1fIAp3LBcizitSfz4RUouhd6CrzoH3fGsVK4YPnzVUMhDX5GHAbxPk00wQd194whzNLBBjMJZ8ZWaDLbRPGyFZAZs2l/qr7aiVBZxdyyWlb5prQS+uSP5QXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ZB92LjnH; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-704466b19c4so1210767a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723821894; x=1724426694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCNUHUhalYmJfkcmHjirMHIoFN5R1oIHSymBUgRqkPU=;
        b=ZB92LjnH3loGuicbAppiYi2IFj6B4/s4qJmRC3UADEPiqk4YhvYkITPaD5G8qVJR8y
         LneyWnPuTywFxIW+XYguPZugSLJFI7C2LbfO6QOhTAH8wky/0nKZ/QwCQy64I6BApNBB
         OhyxfGJ++F6WSh9U4ImTAoyQWMQtB3ylIZBjnQJ3QMMI7v4gMC5y+fG+aiS3/Wf/6eVH
         QckcNuUyUiIkBFJ56ZaWvffo3ZxENFkHokpRZwTG0XBXTngC/4d9UqRa2BNJlLfx+B0D
         QRFCzJWwZnaHFeN9sceTpz3rc+fMIrmbHefkPdpVdR51tQzizN7TsS6JMuXXcAfZYk/G
         T9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723821894; x=1724426694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCNUHUhalYmJfkcmHjirMHIoFN5R1oIHSymBUgRqkPU=;
        b=MV3Sg8HIgi6AtIvf9mgF8vje8g1nPq0pnSBKPXwrU6HIPnoXJXbRsO64csvMoKHYr9
         vnm/AYDdSbqwLwi2WjT/SZG/ubJb4lfIjOAmYtlgJXOUm/KxoKZJZF13v7jfddwrZ7uN
         ecRKkCsImZbYRqnNdXHu8iN2xdz5LQcAOdCfw8sQH1AE40+U2Asb+DiheMNINE4zZL8q
         HnrLObUqtG3mYWG15OHIiTAxOi4Yx19okoc+a3X/YfRodupmIU4/PNpdKrYvEts4cGm6
         qEaHIqhrxqao9NtgZ4wfsC4d2txTILCBqnBYxFWnsbFrcDZK+eHhs6Wd6wmb57o1BKgH
         xc7w==
X-Gm-Message-State: AOJu0Yw4jUWuF+++xSBnCC/epCX8Ck7UEm/7eAL3vFDrTW1jro4QPtMB
	N2RNgmAKPzfl+mO1zzv28a7wfv13/f9p4H3pANmD75cjDbOvpFt0iRW3Sjdxiy4=
X-Google-Smtp-Source: AGHT+IHiJdwu83Ixxqxj+tD6EFiXuAkTzztN0lfn18Y9TtNHJg96G1Tysd9uIP2Nq8btgXgyTKi3Xw==
X-Received: by 2002:a05:6830:2641:b0:703:61ea:f289 with SMTP id 46e09a7af769-70cac8b615dmr2902887a34.28.1723821894514;
        Fri, 16 Aug 2024 08:24:54 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a0596a1sm17437331cf.72.2024.08.16.08.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:24:53 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:24:52 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] inode: remove __I_DIO_WAKEUP
Message-ID: <20240816152452.GA1255093@perftesting>
References: <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org>

On Fri, Aug 16, 2024 at 04:35:52PM +0200, Christian Brauner wrote:
> Afaict, we can just rely on inode->i_dio_count for waiting instead of
> this awkward indirection through __I_DIO_WAKEUP. This survives LTP dio
> and xfstests dio tests.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

