Return-Path: <linux-fsdevel+bounces-14929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844AB881A7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 01:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F921C20FDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 00:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955531C2E;
	Thu, 21 Mar 2024 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cyls+3xI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D27EC;
	Thu, 21 Mar 2024 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710981562; cv=none; b=MXBSlQvOP0qV4FnyXKfrh5PDlCoh4Ah/oNg7Yz+X9w2uwbPQxahFd9oREi8g+DV/HQEO8ZX/sx0/P6tf6J9H66xgyk2Iv6pTels7iiML08LB2kZ4sKKdDQYMgZPdqnAwUYGb+XZOTUVzzT//KSLzKVpWxNHeHxf7gE58kOklWpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710981562; c=relaxed/simple;
	bh=B9vDLy7yEeTbbU0rhNGSNgi3ni7eKud/B6ia/JvcvuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mumjp/QIf6VLjVwLY0TUi/H/Kbquyzgvy4EN5GXylwsSracSF2XirKhx7/8Ffti8W5gK8u3u1XR67U4FXSe+YuHWfTLlXksitLfESSNrqc6a+/oMA3wzQkXMuURQwePsGjAhoi78pLtSjogOL0F2Ov+x4ql58ktEdAnELmawOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cyls+3xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4AAC433F1;
	Thu, 21 Mar 2024 00:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710981561;
	bh=B9vDLy7yEeTbbU0rhNGSNgi3ni7eKud/B6ia/JvcvuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cyls+3xIk+XVddmLij8xROR64ciD+HYnwez6cCJMxnxCudsXktj+/iknYYM9WzpFj
	 ReX5yBF7w250xJmVyts9didaV7fQTSCg4omMV8FWaLN9rZtq0Zo63mG5fj9ylG3od+
	 mqypuXCyNyr84Mr/ubhqct6QzmiMauHG7cPK6rPnJMemBqh2Wfzr9FF6WdidprQgRD
	 OCC91LX3tSJOXtUtIEb95rxG910+YD24qnj7u6oihLEPnq7tTDc6SDRx4PLMaMtgH5
	 /hB28aaNOB1Vuz6XswPsr/RtkmxEC6NVoL77iw0IDRwmTGoV9/sDH95B3OSZ5sXnOq
	 apL9qICtER9nQ==
Date: Wed, 20 Mar 2024 17:39:19 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Light Hsieh =?utf-8?B?KOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Cc: Ed Tsai =?utf-8?B?KOiUoeWul+i7kik=?= <Ed.Tsai@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Chun-Hung Wu =?utf-8?B?KOW3q+mnv+Wujyk=?= <Chun-hung.Wu@mediatek.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= f2fs F2FS_IOC_SHUTDOWN hang
 issue
Message-ID: <ZfuBt1QbfFfJ-IKz@google.com>
References: <0000000000000b4e27060ef8694c@google.com>
 <20240115120535.850-1-hdanton@sina.com>
 <4bbab168407600a07e1a0921a1569c96e4a1df31.camel@mediatek.com>
 <SI2PR03MB52600BD4AFAD1E324FD0430584332@SI2PR03MB5260.apcprd03.prod.outlook.com>
 <ZftBxmBFmGCFg35I@google.com>
 <SI2PR03MB526094D44AB0A536BD0D1F5B84332@SI2PR03MB5260.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR03MB526094D44AB0A536BD0D1F5B84332@SI2PR03MB5260.apcprd03.prod.outlook.com>

On 03/20, Light Hsieh (謝明燈) wrote:
> On 2024/3/20 8:14, Jaegeuk Kim wrote:
> > f2fs_ioc_shutdown(F2FS_GOING_DOWN_NOSYNC)  issue_discard_thread
> >   - mnt_want_write_file()
> >     - sb_start_write(SB_FREEZE_WRITE)
> >                                               - sb_start_intwrite(SB_FREEZE_FS);
> >   - f2fs_stop_checkpoint(sbi, false,            : waiting
> >      STOP_CP_REASON_SHUTDOWN);
> >   - f2fs_stop_discard_thread(sbi);
> >     - kthread_stop()
> >       : waiting
> > 
> >   - mnt_drop_write_file(filp);
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> The case I encounter is f2fs_ic_shutdown with arg  F2FS_GOING_DOWN_FULLSYNC, not  F2FS_GOING_DOWN_NOSYNC.
> 
> Or you are meaning that: besides the kernel patch, I need to change the invoked F2FS_IOC_SHUTDOWN to use arg F2FS_GOING_DOWN_NOSYNC?

I think this patch also addresses your case by using trylock.

> 
> 
> 

