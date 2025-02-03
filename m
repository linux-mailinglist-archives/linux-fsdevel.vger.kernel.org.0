Return-Path: <linux-fsdevel+bounces-40618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1068A25CBD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AFE7A1EB1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2163D20ADD9;
	Mon,  3 Feb 2025 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AhHsSeis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90D212B0F
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592797; cv=none; b=aEnSibQWRAVVl5tKx7iRzJSyZdUarYdBt6KfgwNJXoEw4OpS45KoW+vOIlZqjJ5j/1wGtrWcof2RzDHFaUKSz/wXPD8S7TRUT2XnhZFzrTuLQcrJpGnsLW3C5qG5ggYz6JosaTSlX7T7hO/PoOEGuQUksTRNRoa7TtP2gr9LSXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592797; c=relaxed/simple;
	bh=Tj7tRy4kZnsxFzQuBtc04+Ahrz10XdqH0zrjX5oVM6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRHnRfRi751IoFETna6CrmTjzQUHv8HpBiweuYPr2xUc+6TU6s9o/GKeZ4WmjaZbENgn/XaHFGNAeuZYQ1NgLfhMt9lBkUOsUyrNqx9u1vkm/TfF9tRixWFrduGuEzgL83YBuSQOqNHYdELaGfEg/8zKn/rFKxdwIds4n1dez+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AhHsSeis; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaeec07b705so732576766b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738592793; x=1739197593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wApwa+Vg7pEhvhJZMOtchLW1Qtniq1LAppbarYJzbvQ=;
        b=AhHsSeisaNRxfF5kpEuWH/NuGkEEpv1vnTj7ov8dvc4SOqrwanUdq0cerpIrAIY5KO
         e0xLN3NncTQKdHp+2y51NgGmv9ulwc6s6YlQvvC8sEwYzXjrmDPfW1P5sJZJVDo2DO7a
         6Lu7iex/hWVl/LNtRHc9nk1a6ySPHTG1l0ZTCGB9wcC1cOHKHvB92C8kPHmpY1ukj9la
         tpeIMaAJAJis7ibRRLXp8njUjDeCMVKXbSKJVW26O/Tr+nSQrg8bmJLV9r5TKEVm9HkD
         0sdyYVw94J5FrQwbw/TXiWME1NugDiPTG57lSyJ2gwt/zJu1Q3tSraQUpYQTCABsq4U6
         osOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738592793; x=1739197593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wApwa+Vg7pEhvhJZMOtchLW1Qtniq1LAppbarYJzbvQ=;
        b=SpbsEgnJAGktJekqjL1AbmEuECKpdiBxFP6tT8gvUiQ2Doejn2fSO1V41ZJpBF4O5x
         0fSAWs+nwa/8RnyZ5egkrdYjcqzbzvspKehJRkqnmPwfcWxytl6SiMpLbphot1Fzy+4g
         KV6I+Fc6b+vwRmkwgMXNFQO+M0O4kXR2MeYnm/szM6jlYez6Z5Hd4dYzzG6A+bK8X35i
         rEgBxFT6Ah3rS3X9AC5R0POBo2laSq01koermlEycgPgS6ST9X67vbEZK2U0EgMP6TMr
         FEHaFFUL53ssfSsPZUUamIvy+D08ubUWgps47R4eWomO4GNuhJs+qaRWsVscfON0ji8X
         6Oxw==
X-Forwarded-Encrypted: i=1; AJvYcCX7iqswibKIwmVdQ+CoHBvUm5D2ySgsc+x7LfsRdagW0HTZduHoN5RhKk5/hckJp5VaF0yl8T9HzpPI9mZN@vger.kernel.org
X-Gm-Message-State: AOJu0YyuacMeSfbXZFxs9epXWfxSfW/H4WkW6/2JnaKzqoMKE0DHjWNb
	mJUTdHDK2C+zCYgidRuxmzR8hapPYlyNjas+l9zUGpfTv1hcgCFnHrRQE75zf/KjeyP1yaaqQdQ
	O
X-Gm-Gg: ASbGncsIiDFnAie9okzcQWbrKIFNlf4N1KNgQcpf32j14dGmj0wTIEIE2+gBXIxsNOF
	aMuOCiuyNWEnZlm6+wU0bj8dq+NBVBBu3O0ZHkpByYXKTVyqlx7qt5eHxcnG50XUP4kJP4llFus
	Rr575UKkdWgJYVT2R9l2LAKwnF85bWpIpbUpIGyNxsUd4GkuBCknHq507x3v82RbD17XlLss73E
	JcFbQ8ixNosmU6vYqM88Y/oxEzatk064TgA+XIYA1Po2tryuyE6aFgdwqMMRsZnbdHQsnYOdhsE
	U3LTsg==
X-Google-Smtp-Source: AGHT+IEMvqFtWMQcGcbew8g5CbtS87OK4kOUrbaUT5fxc6WJnZS+Qe69TNruF9V9SFX0gjEEIeYYSg==
X-Received: by 2002:a17:907:6eab:b0:ab2:ea29:a2 with SMTP id a640c23a62f3a-ab6cfe11e85mr2509321666b.48.1738592793317;
        Mon, 03 Feb 2025 06:26:33 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab706ce9a53sm509134266b.72.2025.02.03.06.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 06:26:33 -0800 (PST)
Date: Mon, 3 Feb 2025 15:26:32 +0100
From: Michal Hocko <mhocko@suse.com>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: REMINDER - LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z6DSGOsqjw1ahIYi@tiehlicka>
References: <Z4pwZkf3px21OVJm@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4pwZkf3px21OVJm@tiehlicka>

On Fri 17-01-25 15:59:51, Michal Hocko wrote:
> Hi,
> this is a friendly reminder for LSF/MM/BPF Call for proposals - you can
> find the original announcement here: https://lore.kernel.org/all/Z1wQcKKw14iei0Va@tiehlicka/T/#u.
> 
> Please also note you need to fill out the following Google form to
> request attendance and suggest any topics for discussion:
> 
>           https://forms.gle/xXvQicSFeFKjayxB9
> 
> The deadline to do that is Feb 1st!

The deadline has passed but if you forgot or this slipped through then
no worries you can still apply but please do so ASAP. We are going
through all applications these days and will try to send invitations
ASAP so that people can start planning their travel.

Let me also remind that all the topics that are to be scheduled should
be posted to the mailing list (CCing track specific and lsf-pc mailing
lists). 

Let us know if you have any questions!

Thanks!
-- 
Michal Hocko
SUSE Labs

