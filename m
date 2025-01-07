Return-Path: <linux-fsdevel+bounces-38599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B93BA04949
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 19:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FDF16478C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 18:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3681F37C0;
	Tue,  7 Jan 2025 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIAsBaH5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D7C1E412E
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274906; cv=none; b=FehucUUhF0EC+3TZWQyDUOlv/jISY9/4RzikID8Cr5aqo4DlCypaRuzxBfNn38Qesk9nreiA7kc2sUdpIsQZsAE1bhyB030EcOe0P9+jPxxMSE71q8JhwkjFrqt3iNcKFKIqNwRujQqjgi0Elsqr1L5QdQvXzF90/dTMljl1IbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274906; c=relaxed/simple;
	bh=M1ARq84HpZATSlKIE0CiJTVb1EV99eJ+tX92dNf1uWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMr7UWMT3IypNg7LgLIiehAtHXP0RUP+oRCX/sVM7quIBZCWyL0JgeJ+CfemqIk/1vNT+I7VzsqmUfTsG0BnPZjOsS1v6MYd7FjOPnipImBG4HnH0A3dI7h3EbC8K64yiDQYcN6bjHOtkQ1dPuPfpchCJALPBigv4CFEGLstfEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XIAsBaH5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736274903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9F6zk1F1mu/VLn8wCR2dDyGVvSSEW0U65BqSMQM8/yE=;
	b=XIAsBaH5WTcpgp2AX3Ml0apOe8hZleavM5GX0mLnK7eA4lNrLjyp839KH3v9P1+8WTUtyr
	8XWyK59lJff6lMEq1afFdZJjmYC2dcc6AdHQ8bYa9ZDEKduDpB3YD0GKEdx24PSJt2HnNO
	PyY5x0+Azx7O1gWW/jy7QNbZ2MljTkg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-iXMG1ggXNfiYQrEKvec1xA-1; Tue,
 07 Jan 2025 13:35:00 -0500
X-MC-Unique: iXMG1ggXNfiYQrEKvec1xA-1
X-Mimecast-MFC-AGG-ID: iXMG1ggXNfiYQrEKvec1xA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D736A1956048;
	Tue,  7 Jan 2025 18:34:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00842195606C;
	Tue,  7 Jan 2025 18:34:56 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] afs: Dynamic root improvements
Date: Tue,  7 Jan 2025 18:34:48 +0000
Message-ID: <20250107183454.608451-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Here are some patches to make a number of improvements to the AFS dynamic
root:

 (1) Create an /afs/.<cell> mountpoint to match the /afs/<cell> mountpoint
     when a cell is created.

 (2) Add some more checks on cell names proposed by the user to prevent
     dodgy symlink bodies from being created.  Also prevent rootcell from
     being altered once set to simplify the locking.

 (3) Change the handling of /afs/@cell from being a dentry name
     substitution at lookup time to making it a symlink to the current cell
     name and also provide a /afs/.@cell symlink to point to the dotted
     cell mountpoint.

The patches are here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-next

Thanks,
David

Changes
=======
ver #2)
 - Add more checks on the cell names.
 - Prevent the rootcell from being altered once set.
 - Directly create the @cell symlinks rather than going through lookup.

Link: https://lore.kernel.org/r/20250107142513.527300-1-dhowells@redhat.com/ # v1

David Howells (3):
  afs: Make /afs/.<cell> as well as /afs/<cell> mountpoints
  afs: Add rootcell checks
  afs: Make /afs/@cell and /afs/.@cell symlinks

 fs/afs/cell.c              |  21 +++-
 fs/afs/dynroot.c           | 227 ++++++++++++++++++++++++++-----------
 fs/afs/proc.c              |   8 +-
 include/trace/events/afs.h |   2 +
 4 files changed, 186 insertions(+), 72 deletions(-)


