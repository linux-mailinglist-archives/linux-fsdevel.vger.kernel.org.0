Return-Path: <linux-fsdevel+bounces-16107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E1898459
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 11:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8590728A4DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 09:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26B9757EB;
	Thu,  4 Apr 2024 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKlac1jf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B68F59B7F
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223596; cv=none; b=Bl/2gm3+cciH+DIVBS/lBHdphtWOnYuVX5uczerznbqGXnLwuxgsHe88PKuItw5gWcC+Ua3ksmHp0Dgy6jifltEelx+YInlxyDMRlQVrOIjH6NIVEeNOSeRFtMibBWA/FunV5qIqP4xp+OYMq8FY+J3BHHp9s5K9BY05qb1dyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223596; c=relaxed/simple;
	bh=Q2J0SHdbDDTKk3cBCCZk1JWW4uClXx9Nvjj8wbCUCz8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CwzJkaaijzZ/o7nmers3IUo+X7JHSeLloN7EhArcode4pQf0A1KrFiTOxtVtOhVgjGUrGHNLOlRRCGfV+awsh5JDlncr9tvayi6nJnNoqOegJtOZ7dQXe4sihr8uC0D4+wLzNO6+kFlGwAgkf5H58lO9tpr4XNNdfd6KSOD4k7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKlac1jf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712223593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Q0Gv0d6rBwe65qsruTCiuIlit9fW3dRsJmEeNPjWAs=;
	b=jKlac1jfNQdvA+3JTwA/VMFUXl03yhZk5IZcGp/I0lFxwqFWFurYaggW4AvhZwK+Xr4eCs
	9ZzOsBVzHsNHt/du7UW/bqLEa6WAbaIigDIHZ3XmQ7SJtyViPL6TrdDoc6q7ngMNlOkbSB
	H05i7SHVVXUNdfW9S9NTJd8Umv1hA/I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-3KsI3PBNM1-8XJ9da5_nog-1; Thu, 04 Apr 2024 05:39:50 -0400
X-MC-Unique: 3KsI3PBNM1-8XJ9da5_nog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C004485A5BA;
	Thu,  4 Apr 2024 09:39:49 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 337BE1C060A4;
	Thu,  4 Apr 2024 09:39:49 +0000 (UTC)
Date: Thu, 4 Apr 2024 11:39:43 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux maintenance release v2.39.4
Message-ID: <20240404093943.jkyn4eimk3humbw2@ws.net.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


The util-linux stable maintenance release v2.39.4 is available at

  http://www.kernel.org/pub/linux/utils/util-linux/v2.39/

Feedback and bug reports, as always, are welcomed.

(Please note that the current stable release is v2.40.)

  Karel


util-linux v2.39.4 Release Notes
================================
 
Security issues
---------------

This release fixes CVE-2024-28085. The wall command does not filter escape
sequences from command line arguments. The vulnerable code was introduced in
commit cdd3cc7fa4 (2013). Every version since has been vulnerable.

This allows unprivileged users to put arbitrary text on other users terminals,
if mesg is set to y and *wall is setgid*. Not all distros are affected (e.g.
CentOS, RHEL, Fedora are not; Ubuntu and Debian wall is both setgid and mesg is
set to y by default).


Changes between v2.39.3 and v2.39.4
-----------------------------------

build:
   - only build test_enosys if an audit arch exists  [Thomas Weiﬂschuh]
dmesg:
   - (tests) validate json output  [Thomas Weiﬂschuh]
   - -r LOG_MAKEPRI needs fac << 3  [Edward Chron]
   - correctly print all supported facility names  [Thomas Weiﬂschuh]
   - only write one message to json  [Thomas Weiﬂschuh]
   - open-code LOG_MAKEPRI  [Thomas Weiﬂschuh]
docs:
   - update AUTHORS file  [Karel Zak]
fadvise:
   - (test) don't compare fincore page counts  [Thomas Weiﬂschuh]
   - (test) dynamically calculate expected test values  [Thomas Weiﬂschuh]
   - (test) test with 64k blocks  [Thomas Weiﬂschuh]
   - (tests) factor out calls to "fincore"  [Thomas Weiﬂschuh]
github:
   - add labeler  [Karel Zak]
jsonwrt:
   - add ul_jsonwrt_value_s_sized  [Thomas Weiﬂschuh]
libblkid:
   - Check offset in LUKS2 header  [Milan Broz]
   - topology/ioctl  correctly handle kernel types  [Thomas Weiﬂschuh]
libmount:
   - don't initialize variable twice (#2714)  [Thorsten Kukuk]
   - make sure "option=" is used as string  [Karel Zak]
libsmartcols:
   - (tests) add test for continuous json output  [Thomas Weiﬂschuh]
   - drop spourious newline in between streamed JSON objects  [Thomas Weiﬂschuh]
   - flush correct stream  [Thomas Weiﬂschuh]
   - only recognize closed object as final element  [Thomas Weiﬂschuh]
po:
   - merge changes  [Karel Zak]
po-man:
   - merge changes  [Karel Zak]
wall:
   - fix calloc cal [-Werror=calloc-transposed-args]  [Karel Zak]
   - fix escape sequence Injection [CVE-2024-28085]  [Karel Zak]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


