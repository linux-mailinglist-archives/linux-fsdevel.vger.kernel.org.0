Return-Path: <linux-fsdevel+bounces-52905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3982AAE831B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 14:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F3B176330
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04742609E1;
	Wed, 25 Jun 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8BxqI/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B4260567
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855651; cv=none; b=Vbresm3Ti6emJkGLEFLUXdXcPBTYtm6IiE7hrIyuV+AeiHV268nuBiYwjAve/L2EL/MsBV2E0nbPBFfU1RYQuJKXLbgwo77SC6yroPNcZOVEyj4sobDMNz4gzrvSRrIXorQuMQNXZnIsstqOZDSdjpipuK85oVexa809MiquxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855651; c=relaxed/simple;
	bh=H+Ct5E6gqE1GqrxKKgsI88KcM25+Ev2zEH3FOvDCw7Y=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=gWbOR/T9TIowe9GyZ65r42UoOqXGWbqWKILbo5CWOEBSj792EXowj5xDEu/Vl5K8IkoWQQtn5pThsBTDnYCwmi02LKQRfAg+rngbD75kbgyx+V5K8evZKTz1DkLKNcOatcNfni5op/YjbeYttb1q78yGlYAR1sqD3E+VNP8cUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8BxqI/s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750855648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/oWVGyRSPW0/HYVoKtdUnTRZXeUfPLeoGNr3XlUaLrQ=;
	b=H8BxqI/sfrEpYg8rUtGYo6UAgw9NwILSR56zV5LagCbRyZie+LVsF3l2ZuUPtopE6k7n8T
	YEpSXVHTURSu3LhdqPn/PHpI2gr4iZDshJfUKqLXtCTfAfZIJYQZCdS8aIzYWPvfYNEG55
	Yv6MxJ9hzHzsDSwVQyxV7aXSQzYKPw4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-NFK1xPgHPCWFefj36B08xw-1; Wed,
 25 Jun 2025 08:47:23 -0400
X-MC-Unique: NFK1xPgHPCWFefj36B08xw-1
X-Mimecast-MFC-AGG-ID: NFK1xPgHPCWFefj36B08xw_1750855642
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3DD91956089;
	Wed, 25 Jun 2025 12:47:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4302419560AF;
	Wed, 25 Jun 2025 12:47:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1156127.1750774971@warthog.procyon.org.uk>
References: <1156127.1750774971@warthog.procyon.org.uk> <f448a729-ca2e-40a8-be67-3334f47a3916@samba.org> <1107690.1750683895@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Stefan Metzmacher <metze@samba.org>,
    "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
    Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH] cifs: Collapse smbd_recv_*() into smbd_recv() and just use copy_to_iter()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1362539.1750855639.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Jun 2025 13:47:19 +0100
Message-ID: <1362540.1750855639@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

David Howells <dhowells@redhat.com> wrote:

> > And 4 is ITER_FOLIOQ.

I dumped some of the fields from the MID involved:

   CIFS: VFS: Invalid msg type 4 (mid=3Da4 optype=3D0 command=3D8)
   CIFS: VFS:  - rcv=3Dcifs_readv_receive+0x0/0x270 cb=3Dsmb2_readv_callba=
ck+0x0/0x480 hand=3Dsmb3_handle_read_data+0x0/0x40

So the ITER_FOLIOQ is from netfslib.  I've attached corresponding trace lo=
g,
edited down a bit to remove some columns.  Note that the EINVAL error gets
discarded by cifs_demultiplex_thread() and replaced with EAGAIN by netfsli=
b.

David
---
         diff-6828: netfs_rreq_ref: R=3D0000000c NEW         r=3D2
         diff-6828: netfs_read: R=3D0000000c READPAGE  c=3D00000000 ni=3D1=
d4072 s=3D0 l=3D1000 sz=3D400
         diff-6828: netfs_rreq_ref: R=3D0000000c GET SUBREQ  r=3D3
         diff-6828: smb3_rw_credits: R=3D0000000c[1] rd-submit   cred=3D16=
 chg=3D0 pool=3D1688 ifl=3D1
         diff-6828: netfs_sreq: R=3D0000000c[1] DOWN PREP  f=3D000 s=3D0 0=
/400 s=3D0 e=3D0
         diff-6828: smb3_rw_credits: R=3D0000000c[1] rd-issu-adj cred=3D16=
 chg=3D-15 pool=3D1688 ifl=3D1
         diff-6828: netfs_sreq: R=3D0000000c[1] DOWN SUBMT f=3D102 s=3D0 0=
/400 s=3D0 e=3D0
         diff-6828: netfs_rreq_ref: R=3D0000000c GET SUBREQ  r=3D4
         diff-6828: netfs_sreq: R=3D0000000c[2] ZERO SUBMT f=3D000 s=3D400=
 0/c00 s=3D0 e=3D0
         diff-6828: netfs_sreq: R=3D0000000c[2] ZERO TERM  f=3D102 s=3D400=
 c00/c00 s=3D1 e=3D0
         diff-6828: netfs_collect_stream: R=3D0000000c[0:] cto=3D0 frn=3D0
         diff-6828: netfs_rreq: R=3D0000000c RP WAIT-IP f=3D03
        cifsd-6506: netfs_sreq: R=3D0000000c[1] DOWN I-RTR f=3D102 s=3D0 0=
/400 s=3D0 e=3D0
        cifsd-6506: smb3_read_err:       R=3D0000000c[1] xid=3D200 sid=3D0=
x8 tid=3D0x2 fid=3D0xa0952 offset=3D0x0 len=3D0x400 rc=3D-11
        cifsd-6506: smb3_rw_credits: R=3D0000000c[1] rd-resp-clr cred=3D1 =
chg=3D0 pool=3D1703 ifl=3D1
        cifsd-6506: netfs_sreq: R=3D0000000c[1] DOWN I-OK  f=3D302 s=3D0 0=
/400 s=3D0 e=3D-11
        cifsd-6506: netfs_failure: R=3D0000000c[1] DOWN f=3D302 s=3D0 0/40=
0 read e=3D-11
        cifsd-6506: netfs_rreq: R=3D0000000c RP PAUSE   f=3D03
        cifsd-6506: netfs_sreq: R=3D0000000c[1] DOWN TERM  f=3D702 s=3D0 0=
/400 s=3D0 e=3D-11
        cifsd-6506: netfs_rreq: R=3D0000000c RP WAKE-Q  f=3D07
        cifsd-6506: smb3_rw_credits: R=3D0000000c[1] rd-resp-add cred=3D0 =
chg=3D0 pool=3D1703 ifl=3D1
         diff-6828: netfs_collect_stream: R=3D0000000c[0:] cto=3D0 frn=3D0
         diff-6828: netfs_rreq: R=3D0000000c RP COLLECT f=3D07
         diff-6828: netfs_collect: R=3D0000000c s=3D0-1000
         diff-6828: netfs_collect_sreq: R=3D0000000c[0:01] s=3D0 t=3D0/400
         diff-6828: netfs_rreq: R=3D0000000c RP S-ABNDN f=3D07
         diff-6828: netfs_sreq: R=3D0000000c[1] DOWN ABNDN f=3D602 s=3D0 4=
00/400 s=3D0 e=3D-11
         diff-6828: netfs_sreq: R=3D0000000c[1] DOWN FREE  f=3D602 s=3D0 4=
00/400 s=3D0 e=3D-11
         diff-6828: netfs_rreq_ref: R=3D0000000c PUT SUBREQ  r=3D3
         diff-6828: netfs_collect_sreq: R=3D0000000c[0:02] s=3D400 t=3Dc00=
/c00
         diff-6828: netfs_sreq: R=3D0000000c[2] ZERO ABNDN f=3D002 s=3D400=
 c00/c00 s=3D1 e=3D0
         diff-6828: netfs_sreq: R=3D0000000c[2] ZERO FREE  f=3D002 s=3D400=
 c00/c00 s=3D1 e=3D0
         diff-6828: netfs_rreq_ref: R=3D0000000c PUT SUBREQ  r=3D2
         diff-6828: netfs_collect_stream: R=3D0000000c[0:] cto=3D1000 frn=3D=
ffffffff
         diff-6828: netfs_collect_state: R=3D0000000c col=3D1000 cln=3D100=
0 n=3D8c
         diff-6828: netfs_rreq: R=3D0000000c RP UNPAUSE f=3D0b
         diff-6828: netfs_collect_stream: R=3D0000000c[0:] cto=3D1000 frn=3D=
ffffffff
         diff-6828: netfs_collect_state: R=3D0000000c col=3D1000 cln=3D100=
0 n=3D8
         diff-6828: netfs_rreq: R=3D0000000c RP COMPLET f=3D0b
         diff-6828: netfs_rreq: R=3D0000000c RP WAKE-IP f=3D0a
         diff-6828: netfs_rreq: R=3D0000000c RP DONE    f=3D0a
         diff-6828: netfs_rreq_ref: R=3D0000000c PUT WORK IP  r=3D1
         diff-6828: netfs_rreq: R=3D0000000c RP DONE-IP f=3D0a
         diff-6828: netfs_rreq_ref: R=3D0000000c PUT RETURN  r=3D0
kworker/u16:0-12  : netfs_rreq: R=3D0000000c RP FREE    f=3D0a


