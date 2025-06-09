Return-Path: <linux-fsdevel+bounces-51036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F4DAD2104
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726C23A9753
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE7F25D20A;
	Mon,  9 Jun 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLHQZj60"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C225B1F7;
	Mon,  9 Jun 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479774; cv=none; b=uE/zHYnF2E/QPJILFDSIuuF/GU3G+ZzxbPO4hQPtO7WNRNuLPdukWtUEqToYq3CjU1zXeSDv+gPLuH2IkKCsfi5t9ftSOVkubS9AfKIav46nlQm49opqPJhLWd4GOTFbv4jPTu1he26CWFthzwo+o35fR3vBXaz7S14ay4ZFNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479774; c=relaxed/simple;
	bh=Z/gbxRh7TtF3hWyIUnvehVYQEUvT10IpNv9VZ/0R8sY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=maZO1w3atczkqFGdZuTo+NKWDgP0DcbL3p6faKRDBMwjBeae2CT8CPKqmo4gWxBCHzvaBjrf0kWFTfllVBg82Qj2sZZoGobsieKwBkAqKIDuGPNiieyjO3UaeBUkScrQuAwCq4x2xsfqKKoq3momQ/oStktLnnOnSuROrdO0K18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLHQZj60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B05C4CEED;
	Mon,  9 Jun 2025 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749479774;
	bh=Z/gbxRh7TtF3hWyIUnvehVYQEUvT10IpNv9VZ/0R8sY=;
	h=From:To:Cc:Subject:Date:From;
	b=HLHQZj60CAAKylorQphygH0ZdrpToKSfjaDedS6aYZcyrjn7gVhdTUwFsa/Dp2XQ6
	 mI0s86oEbhV9UWrYtq3IYMnKLIKH6n5EvjkRsAkVPumwaVcthVLtC2TTJIvvO+kp/f
	 Mkpur0gROeAJ2/AWARLHC+4q0CB7dmohGYzGrfjOtvT1FHz8vxnyxx69In+ObPI0WV
	 rL3wX0fZfr8iy5FBYnAOLb92U1UQhuLOYehiZs89zVq6opaxryfVJfE5/E7wSrJhpJ
	 2E96xIsGHuNVgWPDRGnMyTpAJht7PwryOeMr/ZfvPcPGJKpPg3Te/DlFW3ZNBCp5uc
	 kfSM3Gi9K0FGQ==
From: Hans de Goede <hansg@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hansg@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-ide@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2 0/1] MAINTAINERS: .mailmap: Update Hans de Goede's email address
Date: Mon,  9 Jun 2025 16:35:56 +0200
Message-ID: <20250609143558.42941-1-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

I'm moving all my kernel work over to using my kernel.org email address.

The single patch in this series updates .mailmap and all MAINTAINERS
entries still using hdegoede@redhat.com.

Since most of my work is pdx86 related I believe it would be best for Ilpo
to merge this through the pdx86 tree (preferable through the fixes branch).

Other subsystem MAINTAINERS are Cc-ed FYI and can otherwise ignore this.

Changes in v2:
- For v1 I only included pdx86 drivers in the MAINTAINERS file, thinking
  that I would split out the rest and send it as separate patches to
  various subsystem maintainers. But when I tried to implement that it
  became a bit messy. So now this is just one patch updating all entries
  in one go.

Regards,

Hans


Hans de Goede (1):
  MAINTAINERS: .mailmap: Update Hans de Goede's email address

 .mailmap    |  1 +
 MAINTAINERS | 72 ++++++++++++++++++++++++++---------------------------
 2 files changed, 37 insertions(+), 36 deletions(-)

-- 
2.49.0


