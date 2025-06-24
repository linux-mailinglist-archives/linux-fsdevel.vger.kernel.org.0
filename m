Return-Path: <linux-fsdevel+bounces-52819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6540DAE72D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB821720CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899C325BF12;
	Tue, 24 Jun 2025 23:07:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E2255F53;
	Tue, 24 Jun 2025 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806438; cv=none; b=Q5O0y6FkhyVHjLlsFClCkYTvNZnJE+8Wmb7a8NjvNWBfmpHSOc0VUySF6gO/J525MGbrK1lhXYHSyeypaVboGZRrAtl+2XfioWocMZVxTTWqvJa0TpoLeg74uoYoI5GqIU5wd/f0+dYQ6Dy8CwIvDiPTrn+nTHe3aSlpYcTXk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806438; c=relaxed/simple;
	bh=K1z2OQdeMv0uKHl/qvd02/WNc0q14MTYw4FKvLIvCzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYI0VrieZ+v4Vfp1yTzQwgs727yeYYh3wtECta7oIib79mMuh0HwNxG5bpP7/fhIQQkmxoi2hNCZB0RZWL0/bA4nezTaAe0GDg8epyySjpQkLkt9eTYnJu7kJ0ChYDrmue95Ku+1dbUUI3XRpeWznTc7P31RyHmj4f/I7ntIsGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjQ-0045c6-5M;
	Tue, 24 Jun 2025 23:07:12 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/12] ovl: narrow regions protected by directory i_rw_sem
Date: Wed, 25 Jun 2025 08:54:56 +1000
Message-ID: <20250624230636.3233059-1-neil@brown.name>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches for overlayfs is primarily focussed on preparing
for some proposed changes to directory locking.  In the new scheme we
wil lock individual dentries in a directory rather than the whole
directory.

ovl currently will sometimes lock a directory on the upper filesystem
and do a few different things while holding the lock.  This is
incompatible with the new scheme.

This series narrows the region of code protected by the directory lock,
taking it multiple times when necessary.  This theoretically open up the
possibilty of other changes happening on the upper filesytem between the
unlock and the lock.  To some extent the patches guard against that by
checking the dentries still have the expect parent after retaking the
lock.  In general, I think ovl would have trouble if upperfs were being
changed independantly, and I don't think the changes here increase the
problem in any important way.

The first patch in this series doesn't exactly match the above, but it
does relate to directory locking and I think it is a sensible
simplificaiton.

I have tested this with fstests, both generic and unionfs tests.  I
wouldn't be surprised if I missed something though, so please review
carefully.

After this series (with any needed changes) lands I will resubmit my
change to vfs_rmdir() behaviour to have it drop the lock on error.  ovl
will be much better positioned to handle that change.  It will come with
the new "lookup_and_lock" API that I am proposing.

Thanks,
NeilBrown

 [PATCH 01/12] ovl: use is_subdir() for testing if one thing is a
 [PATCH 02/12] ovl: Call ovl_create_temp() and ovl_create_index()
 [PATCH 03/12] ovl: narrow the locked region in ovl_copy_up_workdir()
 [PATCH 04/12] ovl: narrow locking in ovl_create_upper()
 [PATCH 05/12] ovl: narrow locking in ovl_clear_empty()
 [PATCH 06/12] ovl: narrow locking in ovl_create_over_whiteout()
 [PATCH 07/12] ovl: narrow locking in ovl_rename()
 [PATCH 08/12] ovl: narrow locking in ovl_cleanup_whiteouts()
 [PATCH 09/12] ovl: whiteout locking changes
 [PATCH 10/12] ovl: narrow locking in ovl_check_rename_whiteout()
 [PATCH 11/12] ovl: change ovl_create_real() to receive dentry parent
 [PATCH 12/12] ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()

