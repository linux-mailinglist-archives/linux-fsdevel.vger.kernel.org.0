Return-Path: <linux-fsdevel+bounces-29648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE0D97BD9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3531C2280C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E5D18A931;
	Wed, 18 Sep 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ikv7hMcT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49D176230
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668231; cv=none; b=d1lnISBaa2j1BRSru3pI69or6ClrrVdftmeUaY7jFXHRKgyOZzZnqTZu0AgS2TKx0H01M3bSeZSCAJzw7jsdrtQKiytG6Zx0gEyPfJh8CqpMT+SPEoOiPxE0+9hBffGByacyr3BQVBIqu/2C9hBf+gpmNfPXIivFmRDQ60M/H/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668231; c=relaxed/simple;
	bh=Kr3ea7knxR3K6ncu1yZFkSOzoV0ZNlUKfvGocBFxRZ4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=g3DgvH3ptbnJUSU3qvwZxAbyINH25GItOXil6Qgm0Cs2w7bNJVnusDlsuIUW64ra3s/BocXGzu37YIpUVqucKx8yHib2PsTy0BWgebB+FJ0t/VRpRVSCE+2Fkou+gYJ8NWyp3jMRppSs4anFJrYXQD4/kHrU5nxOdh87LR4E9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ikv7hMcT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726668228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vDScTiHdr0sgOehdKhcZpjyeGo146YPJ6YCQDqIElU=;
	b=Ikv7hMcTqglOvDA1VAPs6XlPedVOLTtxySgtiNQ6gjmDlj3bTBRougwDtTCySn3UK7RY6v
	81FUbTio7Vs11qweCOxhV4ZSfYok2vuOyBJkNbE992PZdaZiOiSfTGzhXTpRB+x8SkxzCD
	s762C4IxMiuKo5GAOUU5OSU87p2B+lQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-7e-FGBkuNbGTNhpDoCvOxA-1; Wed,
 18 Sep 2024 10:03:47 -0400
X-MC-Unique: 7e-FGBkuNbGTNhpDoCvOxA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70CF51955E99;
	Wed, 18 Sep 2024 14:03:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C67BB19560AA;
	Wed, 18 Sep 2024 14:03:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <202409131438.3f225fbf-oliver.sang@intel.com>
References: <202409131438.3f225fbf-oliver.sang@intel.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: dhowells@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
    Linux Memory Management List <linux-mm@kvack.org>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [netfs] a05b682d49: BUG:KASAN:slab-use-after-free_in_copy_from_iter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2377097.1726668218.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Sep 2024 15:03:38 +0100
Message-ID: <2377098.1726668218@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Oliver,

The reproducer script doesn't manage to build (I'm using Fedora 39):

+ /usr/lib/rpm/check-rpaths
**************************************************************************=
*****
*
* WARNING: 'check-rpaths' detected a broken RPATH OR RUNPATH and will caus=
e
*          'rpmbuild' to fail. To ignore these errors, you can set the
*          '$QA_RPATHS' environment variable which is a bitmask allowing t=
he
*          values below. The current value of QA_RPATHS is 0x0000.
*
*    0x0001 ... standard RPATHs (e.g. /usr/lib); such RPATHs are a minor
*               issue but are introducing redundant searchpaths without
*               providing a benefit. They can also cause errors in multili=
b
*               environments.
*    0x0002 ... invalid RPATHs; these are RPATHs which are neither absolut=
e
*               nor relative filenames and can therefore be a SECURITY ris=
k
*    0x0004 ... insecure RPATHs; these are relative RPATHs which are a
*               SECURITY risk
*    0x0008 ... the special '$ORIGIN' RPATHs are appearing after other
*               RPATHs; this is just a minor issue but usually unwanted
*    0x0010 ... the RPATH is empty; there is no reason for such RPATHs
*               and they cause unneeded work while loading libraries
*    0x0020 ... an RPATH references '..' of an absolute path; this will br=
eak
*               the functionality when the path before '..' is a symlink
*          =

*
* Examples:
* - to ignore standard and empty RPATHs, execute 'rpmbuild' like
*   $ QA_RPATHS=3D$(( 0x0001|0x0010 )) rpmbuild my-package.src.rpm
* - to check existing files, set $RPM_BUILD_ROOT and execute check-rpaths =
like
*   $ RPM_BUILD_ROOT=3D<top-dir> /usr/lib/rpm/check-rpaths
*  =

**************************************************************************=
*****
ERROR   0002: file '/usr/local/sbin/fsck.f2fs' contains an invalid runpath=
 '/usr/local/lib' in [/usr/local/lib]
ERROR   0002: file '/usr/local/sbin/mkfs.f2fs' contains an invalid runpath=
 '/usr/local/lib' in [/usr/local/lib]
ERROR   0002: file '/usr/local/lib/libf2fs_format.so.9.0.0' contains an in=
valid runpath '/usr/local/lib' in [/usr/local/lib]
error: Bad exit status from /var/tmp/rpm-tmp.ASUBws (%install)

RPM build warnings:
    source_date_epoch_from_changelog set but %changelog is missing

RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.ASUBws (%install)
error: open of /mnt2/lkp-tests/programs/xfstests/pkg/rpm_build/RPMS/xfstes=
ts-LKP.rpm failed: No such file or directory
=3D=3D> WARNING: Failed to install built package(s).


