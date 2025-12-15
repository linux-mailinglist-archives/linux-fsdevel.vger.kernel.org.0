Return-Path: <linux-fsdevel+bounces-71352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB594CBE92A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 16:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67ABA305DCF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3F8331A4B;
	Mon, 15 Dec 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiaYXPhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304533121E
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810956; cv=none; b=UukS3jNumHrNZX6tR0p+Gekw/t5n69qNUOQK39MSC0r6js5tL5g6B88i43gvvne2r+DuHrBjAf93+gm2he2+jQlP31hDmDtjbgd/BirPN7XRPTdNi4P7V9mAmnSGfdECnT2JLDfqxYXCyzelCCBcqRbDqmo7piuypzHIfVXsJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810956; c=relaxed/simple;
	bh=9DIbAAS4fmLPWh9z1hwJEGriinnfU6EzsYhzAkF4FYQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p9u31Ibz5Q2/ojr43hmE8s8kUofrwDQYH8UlUXCPUunE23yH+LKeEgPGwHxvRueRHczDUI9A0jPHwNPzMWj0QFztjTOj8SyLCXDLKzKTJh0OGZMHXz8UcKDAMLog4Xc6/NC2UctQZ0qFAv5Zss2wknR6dVYbKU6C00WJ9ClJ1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiaYXPhk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765810953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ef9lgEblGmTogvoJK7b07OBRK+jbjZpqLe2jJTbo2Do=;
	b=TiaYXPhkS6LhqjH1kpUCSmfa7zfHAfyht4erORBa//o0ett7ONB4UZ/fddbXK9ko3OMVTE
	GikQZTmlDxD8WF//6o4amKa4jAs6Yq8bvGqj88Agv2gQ4/YeddlbICKXRQEbSAZWOjCqvR
	Ul0yhMojHp+h8Q1ef1gVC1Xh34sAJEs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-LWdApg1OOIW2RewCnqm2eQ-1; Mon,
 15 Dec 2025 10:02:32 -0500
X-MC-Unique: LWdApg1OOIW2RewCnqm2eQ-1
X-Mimecast-MFC-AGG-ID: LWdApg1OOIW2RewCnqm2eQ_1765810951
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F9C0195608E;
	Mon, 15 Dec 2025 15:02:30 +0000 (UTC)
Received: from ws (unknown [10.45.242.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D50619560A7;
	Mon, 15 Dec 2025 15:02:28 +0000 (UTC)
Date: Mon, 15 Dec 2025 16:02:25 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.41.3
Message-ID: <no7nihf3ju4e6wndc45z2lro67ygi7ezebnxy63abjlart77iz@l6bynuajkn5l>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


The util-linux release v2.41.3 is now available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.41
 
This release addresses build issues with GCC 15 (C23) and fixes
CVE-2025-14104.

Feedback and bug reports, as always, are welcomed.
 
  Karel



util-linux 2.41.3 Release Notes
===============================

bash-completion:
    - (mount) add missing options (by Christian Goeschel Ndjomouo)
    - add lsfd (by Karel Zak)
    - add blkpr (by Karel Zak)
    - add bits to dist tarball (by Karel Zak)

dmesg:
    - fix const qualifier warnings in parse_callerid (by Karel Zak)

eject:
    - fix const qualifier warning in read_speed (by Karel Zak)

enosys:
    - fix const qualifier warning in parse_block (by Karel Zak)

libblkid:
    - fix const qualifier warning in blkid_parse_tag_string (by Karel Zak)
    - use snprintf() instead of sprintf() (by Karel Zak)

libfdisk:
    - (dos) fix off-by-one in maximum last sector calculation (by Karel Zak)

liblastlog2:
    - fix operator precedence in conditional assignments (by Karel Zak)

lib, lscpu:
    - fix const qualifier discarded warnings in bsearch (by Karel Zak)

libmount:
    - fix const qualifier warning in mnt_parse_mountinfo_line (by Karel Zak)
    - fix const qualifier warnings for C23 (by Karel Zak)

logger:
    - fix const qualifier warnings for C23 (by Karel Zak)

login-utils:
    - fix setpwnam() buffer use [CVE-2025-14104] (by Karel Zak)

losetup:
    - sort 'O' correctly for the mutual-exclusive check to work (by Benno Schulenberg)

lscpu:
    - use maximum CPU speed from DMI, avoid duplicate version string (by Karel Zak)
    - Add a few missing Arm CPU identifiers (by Jonathan Thackray)

lsfd:
    - fix memory leak related to stat_error_class (by Masatake YAMATO)
    - (bugfix) use PRIu32 for prining lport of netlink socket (by Masatake YAMATO)
    - fix const qualifier warning in strnrstr (by Karel Zak)
    - fix const qualifier warning in new_counter_spec (by Karel Zak)
    - fix bsearch macro usage with glibc C23 (by Cristian Rodríguez)

lsns:
    - fix const qualifier warnings for C23 (by Karel Zak)

namei:
    - fix const qualifier warning in readlink_to_namei (by Karel Zak)

partx:
    - fix const qualifier warning in get_max_partno (by Karel Zak)

po:
    - update sr.po (from translationproject.org) (by Мирослав Николић)

po-man:
    - merge changes (by Karel Zak)
    - update sr.po (from translationproject.org) (by Мирослав Николић)

umount:
    - consider helper return status for success message (by Christian Goeschel Ndjomouo)

wdctl:
    - remove -d option leftover (by Munehisa Kamata)

whereis:
    - fix const qualifier warnings for C23 (by Karel Zak)

Misc:
    - Fix memory leak in setpwnam() (by yao zhang)


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


