Return-Path: <linux-fsdevel+bounces-26255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD009569AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 13:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF35E1C21A06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D416B74A;
	Mon, 19 Aug 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgwPGCIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040EA16B396
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068030; cv=none; b=ZlWda8rHCmsVFkRI/CCkpj9v65oCYNKrShMJmS4mNidSC62TCUF+UEwhmzB5pxRAs8iY8T2NSZVtarW9LIHt3vcVQNiCKLDs3n85xBHdgu/e/uKarwkPL3JPYnRPHeKXBBbAIfOL0L+zcUa73np9p72CMGuID7uIXjIA03OXWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068030; c=relaxed/simple;
	bh=6THoPfDJ4DaIHDJGHkyac3o4Tj9/qF0aMMiW5s1/rNE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=haQ1ebX/Mhv+5bK3o9U0oAa2ts/6IwF4LGXG3AheAICc3cf/nJdfT4vOQt2r2Kpum8/3V/gjYxmUc0R39t5QbWjAoQi4WqCKn0FCt/ort7FpuugLgmrZERqT8O5xQsasDSeskqqSogil1aNx5PJFrF5SRZI22D+R+RRhk1OcVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZgwPGCIl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724068027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BXnkxNev4eqM9SF7QxyJDhAGvzkKQgET2zOAAZoUuI=;
	b=ZgwPGCIld4xEhG/fbe2Yx/lkzKxzbGmkFNWYB5G+ZkgbYuASQ5ccfsr9+Wu8ncq6spy1iN
	ZvHxyO8eQHrfGmaqTGiR0vxQTKcLV6woinPrE16Gu+useKrJ1WAhTd5Yh5q/VeZssQakv+
	pJ4kbFhnM2YZ1WjftLqOp/euxTJuN3E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85--2BxB3vTOoaoqk81-59JpA-1; Mon,
 19 Aug 2024 07:47:06 -0400
X-MC-Unique: -2BxB3vTOoaoqk81-59JpA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAA5F1955BEE;
	Mon, 19 Aug 2024 11:47:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75E1F19773E0;
	Mon, 19 Aug 2024 11:46:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240818165124.7jrop5sgtv5pjd3g@quentin>
References: <20240818165124.7jrop5sgtv5pjd3g@quentin> <20240815090849.972355-1-kernel@pankajraghav.com> <2924797.1723836663@warthog.procyon.org.uk>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: dhowells@redhat.com, brauner@kernel.org, akpm@linux-foundation.org,
    chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org,
    djwong@kernel.org, hare@suse.de, gost.dev@samsung.com,
    linux-xfs@vger.kernel.org, hch@lst.de, david@fromorbit.com,
    Zi Yan <ziy@nvidia.com>, yang@os.amperecomputing.com,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    willy@infradead.org, john.g.garry@oracle.com,
    cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
    ryan.roberts@arm.com
Subject: Re: [PATCH v12 00/10] enable bs > ps in XFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3402932.1724068015.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Aug 2024 12:46:55 +0100
Message-ID: <3402933.1724068015@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Pankaj,

I can reproduce the problem with:

xfs_io -t -f -c "pwrite -S 0x58 0 40" -c "fsync" -c "truncate 4" -c "trunc=
ate 4096" /xfstest.test/wubble; od -x /xfstest.test/wubble

borrowed from generic/393.  I've distilled it down to the attached C progr=
am.

Turning on tracing and adding a bit more, I can see the problem happening.
Here's an excerpt of the tracing (I've added some non-upstream tracepoints=
).
Firstly, you can see the second pwrite at fpos 0, 40 bytes (ie. 0x28):

 pankaj-5833: netfs_write_iter: WRITE-ITER i=3D9e s=3D0 l=3D28 f=3D0
 pankaj-5833: netfs_folio: pfn=3D116fec i=3D0009e ix=3D00000-00001 mod-str=
eamw

Then first ftruncate() is called to reduce the file size to 4:

 pankaj-5833: netfs_truncate: ni=3D9e isz=3D2028 rsz=3D2028 zp=3D4000 to=3D=
4
 pankaj-5833: netfs_inval_folio: pfn=3D116fec i=3D0009e ix=3D00000-00001 o=
=3D4 l=3D1ffc d=3D78787878
 pankaj-5833: netfs_folio: pfn=3D116fec i=3D0009e ix=3D00000-00001 inval-p=
art
 pankaj-5833: netfs_set_size: ni=3D9e resize-file isz=3D4 rsz=3D4 zp=3D4

You can see the invalidate_folio call, with the offset at 0x4 an the lengt=
h as
0x1ffc.  The data at the beginning of the page is 0x78787878.  This looks
correct.

Then second ftruncate() is called to increase the file size to 4096
(ie. 0x1000):

 pankaj-5833: netfs_truncate: ni=3D9e isz=3D4 rsz=3D4 zp=3D4 to=3D1000
 pankaj-5833: netfs_inval_folio: pfn=3D116fec i=3D0009e ix=3D00000-00001 o=
=3D1000 l=3D1000 d=3D78787878
 pankaj-5833: netfs_folio: pfn=3D116fec i=3D0009e ix=3D00000-00001 inval-p=
art
 pankaj-5833: netfs_set_size: ni=3D9e resize-file isz=3D1000 rsz=3D1000 zp=
=3D4

And here's the problem: in the invalidate_folio() call, the offset is 0x10=
00
and the length is 0x1000 (o=3D and l=3D).  But that's the wrong half of th=
e folio!
I'm guessing that the caller thereafter clears the other half of the folio=
 -
the bit that should be kept.

David
---
/* Distillation of the generic/393 xfstest */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#define ERR(x, y) do { if ((long)(x) =3D=3D -1) { perror(y); exit(1); } } =
while(0)

static const char xxx[40] =3D "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
static const char yyy[40] =3D "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy";
static const char dropfile[] =3D "/proc/sys/vm/drop_caches";
static const char droptype[] =3D "3";
static const char file[] =3D "/xfstest.test/wubble";

int main(int argc, char *argv[])
{
        int fd, drop;

	/* Fill in the second 8K block of the file... */
        fd =3D open(file, O_CREAT|O_TRUNC|O_WRONLY, 0666);
        ERR(fd, "open");
        ERR(ftruncate(fd, 0), "pre-trunc $file");
        ERR(pwrite(fd, yyy, sizeof(yyy), 0x2000), "write-2000");
        ERR(close(fd), "close");

	/* ... and drop the pagecache so that we get a streaming
	 * write, attaching some private data to the folio.
	 */
        drop =3D open(dropfile, O_WRONLY);
        ERR(drop, dropfile);
        ERR(write(drop, droptype, sizeof(droptype) - 1), "write-drop");
        ERR(close(drop), "close-drop");

        fd =3D open(file, O_WRONLY, 0666);
        ERR(fd, "reopen");
	/* Make a streaming write on the first 8K block (needs O_WRONLY). */
        ERR(pwrite(fd, xxx, sizeof(xxx), 0), "write-0");
	/* Now use truncate to shrink and reexpand. */
        ERR(ftruncate(fd, 4), "trunc-4");
        ERR(ftruncate(fd, 4096), "trunc-4096");
        ERR(close(fd), "close-2");
        exit(0);
}


