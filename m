Return-Path: <linux-fsdevel+bounces-23098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E88192721E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 10:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91007B23FBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 08:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A4E1AB500;
	Thu,  4 Jul 2024 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="br+9kUj5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD31AAE17
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083144; cv=none; b=b3FzHonOVSvXdxjtt6k+9k1VUKj1RRdo2qiZGT+cOsnaWjnUXVbB0AE+l3d6UEbb3Mchy8YRIOgLnd7lrCWmgI86yu8l9MYEMQaf2dMC3g5KqPRsQttARoDmXB6ulDjhsdNVwRAVQ9QFfz+kwVsOpvn44zGgttjsyWXpOPv6D74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083144; c=relaxed/simple;
	bh=0Q6EO1vdcF9wTntyw/kOxb1sPugF8eeMbnBpOrz67mg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JgR6iVj5oprKpb5CsH14ABHSvAJ2ndzve+VP3kn1ZCCDWJGWQ0GrYBFEkzvrJfhyd05BaQ+RkA3GGIffaDVVD6yZvS0e0783dhXuaNOP2UCOXRW/3ckqzFxn1q4MKKQe2ia4uKnb2WMN9l2iylhhqFtZ/VLxePj+Bsb881blrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=br+9kUj5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720083142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4LDkzy/lYqg24449f+E5MWYyYh8SWKDByuMk65mfLoU=;
	b=br+9kUj5UptWXeYFDaGFfj24r/8ApRRYKfkycRRRX+m6VmBfiEA8g05V94Brt60JhMmLlG
	kwoqOCmNUIQxGP28ygVEYBgvwLzq1IMkjd+oHpiHNhb4BWU5VFHxm3i/EC5Km0daPyPRSH
	nJSz7Gqa8dvuB8pwm9DlcCgEf0vKdow=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-bqJSw6VWNki9sftxVeARzA-1; Thu,
 04 Jul 2024 04:52:18 -0400
X-MC-Unique: bqJSw6VWNki9sftxVeARzA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F96C19560B1;
	Thu,  4 Jul 2024 08:52:16 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.233])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 119D73000180;
	Thu,  4 Jul 2024 08:52:13 +0000 (UTC)
Date: Thu, 4 Jul 2024 10:52:10 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.40.2
Message-ID: <zmx6wo6ottei3znlkbzfsyok63g365t56agyemojzxmpgsfbrr@2tpaszgblugt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


The util-linux stable maintenance release v2.40.2 is now available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.40/

Feedback and bug reports, as always, are welcomed.
 
  Karel


util-linux v2.40.2 Release Notes
================================

Changes between v2.40.1 and v2.40.2
-----------------------------------

autotools:
   - Properly order install dependencies of pam_lastlog2  [Thomas Weiﬂschuh]
   - make pam install path configurable  [Thomas Weiﬂschuh]
bash-completion:
   - add logger --sd-* completions  [Ville Skytt‰]
build-sys:
   - _PATH_VENDORDIR workaround  [Karel Zak]
cfdisk:
   - fix possible integer overflow [coverity scan]  [Karel Zak]
docs:
   - update AUTHORS file  [Karel Zak]
include/pidfd-utils:
   - provide ENOSYS stubs if pidfd functions are missing  [Thomas Weiﬂschuh]
   - remove hardcoded syscall fallback  [Karel Zak]
lib/buffer:
   - introduce ul_buffer_get_string()  [Thomas Weiﬂschuh]
lib/fileutils:
   - add ul_basename()  [Karel Zak]
lib/path:
   - Fix ul_path_read_buffer() [Daan De Meyer]
lib/sysfs:
   - abort device hierarchy walk at root of sysfs  [Thomas Weiﬂschuh]
   - zero-terminate result of sysfs_blkdev_get_devchain()  [Thomas Weiﬂschuh]
libmount:
   - fix syscall save function  [Karel Zak]
   - fix tree FD usage in subdir hook  [Karel Zak]
   - improving robustness in reading kernel messages  [Karel Zak]
   - add pidfs to pseudo fs list  [Mike Yuan]
libsmartcols:
   - fix reduction stages use  [Karel Zak]
   - ensure filter-scanner/paser.c file is newer than the .h file  [Chen Qi]
libuuid:
   - clear uuidd cache on fork()  [Thomas Weiﬂschuh]
   - drop check for HAVE_TLS  [Thomas Weiﬂschuh]
   - drop duplicate assignment liuuid_la_LDFLAGS  [Karel Zak]
   - split uuidd cache into dedicated struct  [Thomas Weiﬂschuh]
   - Conditionally add uuid_time64 to sym. version map [Nicholas Vinson]
lscpu:
   - New Arm Cortex part numbers  [Jeremy Linton]
lsfd:
   - Refactor the pidfd logic into lsfd-pidfd.c  [Xi Ruoyao]
   - Support pidfs  [Xi Ruoyao]
   - test  Adapt test cases for pidfs  [Xi Ruoyao]
meson:
   - Correctly require the Python.h header for the python dependency  [Jordan Williams]
   - Fix build-python option  [Jordan Williams]
   - Only require Python module when building pylibmount  [Jordan Williams]
misc-utils:
   - uuidd  Use ul_sig_err instead of errx  [Cristian RodrÌguez]
mkswap.8.adoc:
   - update note regarding swapfile creation  [Mike Yuan]
po:
   - merge changes  [Karel Zak]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
   - update ja.po (from translationproject.org)  [Hideki Yoshida]
po-man:
   - merge changes  [Karel Zak]
rename:
   - use ul_basename()  [Karel Zak]
sys-utils/setpgid:
   - make -f work  [Emanuele Torre]
wdctl:
   - always query device node when sysfs is unavailable  [Thomas Weiﬂschuh]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


