Return-Path: <linux-fsdevel+bounces-76718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN1FBvISimlrGAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:01:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD86112CDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A51BC300C0E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530D23859FC;
	Mon,  9 Feb 2026 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdujexEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41873859E8
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656482; cv=none; b=INJ90S2mq5RJrI6DRWU6uceq8eaJPhI6MLbo/NNnMEULsbDyjzDGcqPI+/ODlYnQOJxvkWiMRfTL+EErD5CN5sjn7HvUPpYYetbxdVJmOqnqerrOBI6Cl6AAcGFjIzuzGx49hlzGb0xYoUVledmilUXbKdGBqERut/x3yrHRfXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656482; c=relaxed/simple;
	bh=XoEAkNS8eAIMammm3ima9RQoJ2c+x6YXdtUhSM7fyTk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=UEKJXja8ZIkBI498vxtC9WRLSJSNfS2+zDp2iZwgVfHnLPJKC0mX6Od5f8Alk1VAFXn+vJYxvOW7X28ZCdtnbjxhQnH2ud4IiFdop8hzYuycvNfAFfxH0q7EfrtzMf/staGnNsSkHAmcJ0F/xegoJRuxDNGA3dXOt8GATEwWWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdujexEY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770656481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qETNXrbY4AbTo5xJvG3EQc7RFXMsJYQYC1N6EfSL680=;
	b=FdujexEYTvum5OHjtDiZ4p1MdH0wtr8sKhxt2TLYgVPAGpM8PPq6At3DH0ffjbjGV3Yw68
	79yKc75uMY/2KSh5OUlqZplKu57njtFrvtBueCr4ONHcaasnV2ZjB9oLXEbrg9K9q0prdm
	z9e1v2Lfr+RTun+gtcuWrbMBqhqAzo8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-vhQ5K9pyPVekV40jIQx6JQ-1; Mon,
 09 Feb 2026 12:01:16 -0500
X-MC-Unique: vhQ5K9pyPVekV40jIQx6JQ-1
X-Mimecast-MFC-AGG-ID: vhQ5K9pyPVekV40jIQx6JQ_1770656475
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C40DF1956088;
	Mon,  9 Feb 2026 17:01:14 +0000 (UTC)
Received: from [10.45.224.59] (unknown [10.45.224.59])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4182D18003F6;
	Mon,  9 Feb 2026 17:01:12 +0000 (UTC)
Date: Mon, 9 Feb 2026 18:01:09 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-fsdevel@vger.kernel.org, 
    Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
    syzkaller <syzkaller@googlegroups.com>
Subject: [git pull] HPFS changes for 6.20
Message-ID: <6dd35359-3ffa-8cd5-a614-5410a25335c0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-76718-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mpatocka@redhat.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BD86112CDF
X-Rspamd-Action: no action

Hi Linus

The following changes since commit 18f7fcd5e69a04df57b563360b88be72471d6b62:

  Linux 6.19-rc8 (2026-02-01 14:01:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.20/hpfs-changes

for you to fetch changes up to a4664a2bc61c2abbc772df9139da9dbd2b26dc7f:

  hpfs: disable the no-check mode (2026-02-02 18:06:33 +0100)

Please, pull, thanks
Mikulas

----------------------------------------------------------------
- hpfs: disable the no-check mode
-----BEGIN PGP SIGNATURE-----

iIoEABYIADIWIQRnH8MwLyZDhyYfesYTAyx9YGnhbQUCaYoNkhQcbXBhdG9ja2FA
cmVkaGF0LmNvbQAKCRATAyx9YGnhbb//AQCDnRc0RD46vwY6Vq1H1blOeRBwbuak
wnwekMZFHF5bJAD8DKxQHxXDQeuKJrsY/aRn2GjL32JR0od2XCMM4rIiBQg=
=0Gza
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Mikulas Patocka (1):
      hpfs: disable the no-check mode

 fs/hpfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


