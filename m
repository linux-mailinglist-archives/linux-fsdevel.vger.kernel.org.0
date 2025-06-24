Return-Path: <linux-fsdevel+bounces-52692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BB3AE5EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B351B6788A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1FC258CC9;
	Tue, 24 Jun 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FA6TLM+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD5256C60
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753155; cv=none; b=EYE3juGtsX8p+Ha8g/Ina3Ja7rSrm5iQBCoF+uViZ+tLZHKNUYfZRQb6uziEZPwzrDAkErVoqywyVae7dwHZujDi/4y/T1PH1dbeaGCX+06Is2cs+faBVt7+6mHW6GjJ/TE3seWuYYCv8kyzSFob37YjhQCCvk6rZyvOotfBCXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753155; c=relaxed/simple;
	bh=yL2j1876ItKV5RfwVnsodHgDStUVkQIYx65k9vE3WvI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c0jdiHZJ+3Ojzi1HnOvqzhks8tuX5+fJ9sopd54TiC1M5+wXAZy4c24VJcfJPMWI2pBMlYqVtuZja8nIcqkJ3khD2m8+6qbMyGiA/R5U0yQVhEOE9B0ouKih/379SbYZ65/5YMTbY4llv9NZAOae5D02DxVc0yd2R9qJUy7Fwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FA6TLM+0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750753152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xDy6AvQbreGo32VdcKEdzgul1ZGWwn4DfyAjOh6GrKU=;
	b=FA6TLM+0ScV6P8Mm42Q9HGp820GNOnBU2Qku+1XWX7CxDFtu/v2Xz1pgxQjAuf7nHZ/aI8
	PzdF+ABA5tXGwZzSbreXFPgNvIWi+mpnwKOGDlqkejoYomsslYHXXrKWw3yip4ihvW5InQ
	xeMo3sMgjhv/ZwsFzqujB2VRfUX+weo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-bSqnsK-3PnOUK6GkZIcx0w-1; Tue,
 24 Jun 2025 04:19:10 -0400
X-MC-Unique: bSqnsK-3PnOUK6GkZIcx0w-1
X-Mimecast-MFC-AGG-ID: bSqnsK-3PnOUK6GkZIcx0w_1750753149
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01C861800268;
	Tue, 24 Jun 2025 08:19:09 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB1BF19560A3;
	Tue, 24 Jun 2025 08:19:06 +0000 (UTC)
Date: Tue, 24 Jun 2025 10:19:03 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.41.1
Message-ID: <wnfaquaapqknjnu2bdvddkp2xbleowfcr2g3cqiewpl54oclmi@mrseflcu5nyk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


The util-linux stable release 2.41.1 is now available at
                                  
  http://www.kernel.org/pub/linux/utils/util-linux/v2.41/
                                  
Feedback and bug reports, as always, are welcomed.
                                  
  Karel         


util-linux 2.41.1 Release Notes
===============================

autotools:
    - don't use wide-character ncurses if --disable-widechar (by Karel Zak)

cfdisk:
    - fix memory leak and possible NULL dereference [gcc-analyzer] (by Karel Zak)

column:
    - fix compiler warning for non-widechar compilation (by Karel Zak)

fdformat:
    - use size_t and ssize_t (by Karel Zak)

fdisk:
    - fix possible memory leak (by Karel Zak)

fdisk,partx:
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

findmnt:
    - fix -k option parsing regression (by Karel Zak)

hardlink:
    - define more function as inline (by Karel Zak)
    - fix performance regression (inefficient signal evaluation) (by Karel Zak)
    - Use macro for verbose output (by Karel Zak)

include/cctype:
    - fix string comparison (by Karel Zak)

include/mount-api-utils:
    - include linux/unistd.h (by Thomas Weißschuh)

libblkid:
    - Fix crash while parsing config with libeconf (by Stanislav Brabec)
    - befs fix underflow (by Milan Broz)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

libblkid/src/topology/dm:
    - fix fscanf return value check to match expected number of parsed items (by Mingjie Shen)

libfdisk:
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

libmount:
    - (subdir) restrict for real mounts only (by Karel Zak)
    - (subdir) remove unused code (by Karel Zak)
    - avoid calling memset() unnecessarily (by Karel Zak)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)
    - fix --no-canonicalize regression (by Karel Zak)

libuuid:
    - fix uuid_time on macOS without attribute((alias)) (by Eugene Gershnik)

lsblk:
    - use ID_PART_ENTRY_SCHEME as fallback for PTTYPE (by Karel Zak)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

lscpu:
    - fix possible buffer overflow in cpuinfo parser (by Karel Zak)
    - Fix loongarch op-mode output with recent kernel (by Xi Ruoyao)

lsfd:
    - (bug fix) scan the protocol field of /proc/net/packet as a hex number (by Masatake YAMATO)
    - fix the description for PACKET.PROTOCOL column (by Masatake YAMATO)

lsns:
    - enhance compilation without USE_NS_GET_API (by Karel Zak)
    - fix undefined reference to add_namespace_for_nsfd #3483 (by Thomas Devoogdt)

meson:
    - add feature for translated documentation (by Thomas Weißschuh)
    - remove tinfo dependency from 'more' (by Thomas Weißschuh)
    - fix manadocs for libsmartcols and libblkid (by Karel Zak)
    - fix po-man installation (by Karel Zak)

misc:
    - never include wchar.h (by Karel Zak)

more:
    - fix broken ':!command' command key (by cgoesche)
    - fix implicit previous shell_line execution #3508 (by cgoesche)

mount:
    - (man) add missing word (by Jakub Wilk)

namespace.h:
    - fix compilation on Linux < 4.10 (by Thomas Devoogdt)

po:
    - update uk.po (from translationproject.org) (by Yuri Chornoivan)
    - update sr.po (from translationproject.org) (by Мирослав Николић)
    - update ro.po (from translationproject.org) (by Remus-Gabriel Chelu)
    - update pt.po (from translationproject.org) (by Pedro Albuquerque)
    - update pl.po (from translationproject.org) (by Jakub Bogusz)
    - update nl.po (from translationproject.org) (by Benno Schulenberg)
    - update ja.po (from translationproject.org) (by YOSHIDA Hideki)
    - update hr.po (from translationproject.org) (by Božidar Putanec)
    - update fr.po (from translationproject.org) (by Frédéric Marchal)
    - update es.po (from translationproject.org) (by Antonio Ceballos Roa)
    - update de.po (from translationproject.org) (by Mario Blättermann)
    - update cs.po (from translationproject.org) (by Petr Písař)

po-man:
    - merge changes (by Karel Zak)
    - update sr.po (from translationproject.org) (by Мирослав Николић)
    - update de.po (from translationproject.org) (by Mario Blättermann)

tests:
    - (test_mkfds::mapped-packet-socket) add a new parameter, protocol (by Masatake YAMATO)

treewide:
    - add ul_ to parse_timestamp() function name (by Karel Zak)
    - add ul_ to parse_switch() function name (by Stanislav Brabec)
    - add ul_ to parse_size() function name (by Karel Zak)
    - add ul_ to parse_range() function name (by Karel Zak)
    - fix optional arguments usage (by Karel Zak)
    - avoid strcasecmp() for ASCII-only strings (by Karel Zak)

Wipefs:
    - improve --all descriptions for whole-disks (by Karel Zak)

Misc:
    - Do not call exit() on code ending in shared libraries (by Cristian Rodríguez)
    - remove two leftover license lines from colors.{c,h} (by Benno Schulenberg)
    - remove "Copyright (C) ...." notes from files that claim no copyright (by Benno Schulenberg)
    - correct the full name of the GPL in various files (by Benno Schulenberg)
    - Make scols_column_set_data_func docs visible (by FeRD (Frank Dana))
    - Do not use strerror on shared libraries (by Cristian Rodríguez)
    - Fix typo in blkdiscard docs (by pls-no-hack)
    - lib/fileeq.c Fix a typo in message. (by Masanari Iida)

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


