Return-Path: <linux-fsdevel+bounces-51116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E510AD2F35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 09:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD7A07A821D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A68280013;
	Tue, 10 Jun 2025 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KM1KIahb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFAC25DCEC;
	Tue, 10 Jun 2025 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749541781; cv=none; b=hlLANaPiGMLfr/uobalk+c0a83XIjiJgYTdPn99YpkCD5IY323o2KrpXBWihFEPuc1wTMPNXxLMuOCLITdSH8FsVcJCCGd6Z39pNYbI2OaQHuwbIujjC6Mek42A5Lc4qms7cuwwLceV9Y8mLCl+t59bCI5beFpP/7J8q9BQ1K20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749541781; c=relaxed/simple;
	bh=Zf8zlM1ikY+x+Aj1YRBI4DnaZ4NqNZdfWKGRPGe8aOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MMkrCcqC4hz+K3zv7Q0cL/FoSmv+CGVcMcl5/veM0MDc/qe7DqnRLVH6g5k11f6XIl1SIQDxFTnASgQ02Cl4EdZe9BiS/Ujslfo5TgKkYzjLLvoMXrFB5zTyIom9CbG6Zrpmrkb5fvx68vGiwgNMawZMP0riRCXmfF2s718MjkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KM1KIahb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749541780; x=1781077780;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Zf8zlM1ikY+x+Aj1YRBI4DnaZ4NqNZdfWKGRPGe8aOI=;
  b=KM1KIahbTLOwS1KuFsdOIh5CIwbw4+1A4Wxy1hkKfSCqcMXi3X0/cwLY
   pJu1etFwgDm4UNeU9g5MsfR5cokprtHBuH2ZhkRiWn7xkyVT1DBoTbFrz
   5aNCtfk7qxyHsaxP03+7NBxWa1JItZ7aYc8js139okkHS7XFn8G8KB9CT
   zQiiHQMidT9hQl6j/axycXKvstp8BySjLg2g1u7CKwC7ka8CE13f/OzFg
   VRscBTUqWWKe2llZCj2xCV6jo6md+9ril9jAyi5vCXXQjar3x3aPY9SW5
   vorarPgO+9rT/rrplFubfJkq6EoqirSenJSkGEuvDpukBiOwE6WDIMg8I
   w==;
X-CSE-ConnectionGUID: AOtDDZgQRRSKne8PvFNQhQ==
X-CSE-MsgGUID: 9FihaGAvQBiBEo97XD8fCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="77039694"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="77039694"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 00:49:38 -0700
X-CSE-ConnectionGUID: ufZhjqNVQGCbIO00v9qvhw==
X-CSE-MsgGUID: R8sZ0L7BSHmP28FclTzhsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="146682211"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 00:49:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Hans de Goede <hansg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-ide@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-hwmon@vger.kernel.org
In-Reply-To: <20250609143558.42941-1-hansg@kernel.org>
References: <20250609143558.42941-1-hansg@kernel.org>
Subject: Re: [PATCH v2 0/1] MAINTAINERS: .mailmap: Update Hans de Goede's
 email address
Message-Id: <174954176287.5583.6841576782802896940.b4-ty@linux.intel.com>
Date: Tue, 10 Jun 2025 10:49:22 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 09 Jun 2025 16:35:56 +0200, Hans de Goede wrote:

> I'm moving all my kernel work over to using my kernel.org email address.
> 
> The single patch in this series updates .mailmap and all MAINTAINERS
> entries still using hdegoede@redhat.com.
> 
> Since most of my work is pdx86 related I believe it would be best for Ilpo
> to merge this through the pdx86 tree (preferable through the fixes branch).
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] MAINTAINERS: .mailmap: Update Hans de Goede's email address
      commit: 3fbf25ecf8b7b524b4774b427657d30a24e696ef

--
 i.


