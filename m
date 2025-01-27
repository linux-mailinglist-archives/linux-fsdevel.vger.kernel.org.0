Return-Path: <linux-fsdevel+bounces-40161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64074A20010
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 22:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 752917A3FAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 21:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725AF1D89F8;
	Mon, 27 Jan 2025 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig22jNs5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF31190664
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014268; cv=none; b=V1pb/8XAVb9Vu/QZfQ21TWlt46Asdik90Yg+16apE2UlH79zm14O1kMFfnFzqPtQLTlJb295IRmhCPSJ21vN575VvZCaHRFFphTmWdaUh3ddC7sVpdDmw9VwE3sqRGIZ5gkgG8GjbH3BpRIap+HOwBBQQguKWx24LKT54Nwv/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014268; c=relaxed/simple;
	bh=O55sA32SfjNTeJyXWsvc33ttxoikQbgYnz/eFvivVQM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HPdj+A2hEmmLDyBIi1sFbtvgFiNhiidatrA9XxslgU5+jJeqgXlznbMCFaOnLaaIMIETukgfn13AELMK9fyzu5DPQAOsrjqtUxnsRXkQLG+DK1O9GI8uUlixo8Sf1ThgBXvtPLfo6HEyAWsfgweGpxPH7d/J0hpX9FacsjIGVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig22jNs5; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd5c544813so52051346d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 13:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738014266; x=1738619066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8hNuU6XYKqsSBZpxrR31dc8+TD28Irl+E3HMcwk8S+8=;
        b=ig22jNs5iMkqQt+pN2aeU9Gh6SGwBGNUWRiXblsNL3uRgPTa7HWXp7OmwqMTspA2uh
         1NRXSAzi9uTTnbDTkmuBISRWDoSmUmBtoMtL0rfnfUNNEl3NBgQbej3oy3C/nCT05NaF
         PYnxyM278H7Mis5XoJGcmAdz6boD3UCBDXeiA6BeznBOFtbUKuetdLaxpCwEsok0jv1o
         FBoGdqgMQpgomex2zhjOn70fMVwmJ8VzShVT0hxO7ADNvWQSl0I7NUMYyEqsAQlq+n1D
         hJXu+f8c/TSnMgru5QTDXElsi62WPq+CYZKH2bCBiPYqO4Ih5wbIBLhjxRp3ODP5VofU
         xroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738014266; x=1738619066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hNuU6XYKqsSBZpxrR31dc8+TD28Irl+E3HMcwk8S+8=;
        b=tw6oCXctoEsrltECX5+Ar1r+R57bZQdQDkCh27qaILIER+6en6bTpx4N62t4ZTpQgH
         1WoJWrnWMBTFfV0tEcXi3hI4o+omTi+MbK47AYycWhU40N1T0EO6nRLzi46zKUOuf9GZ
         U1vX//QVVo520tANoi6cCzYt9DiVSNZ3vZ/GDmSB7+XrBeR9RpKPbP/1PfOQ66mzHNpx
         uZX3l+u6/jLxE6nR6aAY36HXdwy72NSRjZ2LfT07Nx8RP4OVT3L/du9VIerpsAofE7dp
         fnCym/wQp0lOihTD36Uxa6YL9HOrKgZQEZ/xpxyxlUk0WN8GbiiPs6xg/OImy1xTBgUM
         K7Dg==
X-Forwarded-Encrypted: i=1; AJvYcCU1XPjXQuB+iTel7MXvoeXbIw0cSl6NksOVThMnIxGTksAMwPncDd2Ck5HgM18xyH91KOSULEBAi5Dl89LM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5yv9PwxMApvojcMm5Gm8UfG+qiUIqv1Syjc+UB4/Llx0QMKxw
	KVPO2NkEl1Qz7xy//n+r28MfNoPDwkK4jeKAAc2h7cLLYP4Xya/h+6h97ifi33+GEQCpTCsomtb
	OYTQmne2E6MSTolk7TUgRtiIuzKA=
X-Gm-Gg: ASbGnctV2TczH9Rho9KFsinNaAD/uwtsAcaUtR8pEnv5EejgiEVD7Wi6nQL9rA9M50v
	1hhsOmlHLJCUrivvq1cGMMDtpFWqgJUjCBVqFHxKczge3IiypcnZ3wEoempXtzGzKf0yw5da8we
	a3zQ==
X-Google-Smtp-Source: AGHT+IEQ8vKuyyf2mG/jjIsA/ly7e4AIarZWWSsZgK5R5utcTu00EJcMG8QB++bbDmpJdXeg8blvHURCy/bbPneE4kE=
X-Received: by 2002:a05:6214:5b8a:b0:6d8:8416:9c54 with SMTP id
 6a1803df08f44-6e1b217d47fmr676285846d6.16.1738014266144; Mon, 27 Jan 2025
 13:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Jan 2025 13:44:15 -0800
X-Gm-Features: AWEUYZnRKGk-LonU_X84Mc2NKHyemXCdtXKIFkAmCIi-bbUgdT8cuz8EFMktLnQ
Message-ID: <CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZFqJg@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Removing writeback temp pages in FUSE
To: lsf-pc@lists.linux-foundation.org
Cc: Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Recently, there was a long discussion upstream [1] on a patchset that
removes temp pages when handling writeback in FUSE. Temp pages are the
main bottleneck for write performance in FUSE and local benchmarks
showed approximately a 20% and 45% improvement in throughput for 4K
and 1M block size writes respectively when temp pages were removed.
More information on how FUSE uses temp pages can be found here [2].

In the discussion, there were concerns from mm regarding the
possibility of untrusted malicious or buggy fuse servers never
completing writeback, which would impede migration for those pages.

It would be great to continue this discussion at LSF/MM and align on a
solution that removes FUSE temp pages altogether while satisfying mm=E2=80=
=99s
expectations for page migration. These are the most promising options
so far:

a) Kill untrusted fuse servers that do not reply to writeback requests
by a certain amount of time (where that time can be configurable
through a sysctl) as a safeguard for system resources

b) Use unmovable pages for untrusted fuse servers

If there are no acceptable solutions, it might also be worth
considering whether there could be mm options that could sufficiently
mitigate this problem. One potential idea is co-locating FUSE folio
allocations to the same page block so that the worst-case
malicious/buggy server scenario only hampers migration of one page
block.

If there is no way to remove temp pages altogether, then it would be
useful to discuss:
a) how skipping temp pages should be gated:
    i) unprivileged servers default to always using temp pages while
privileged servers skip temp pages
    ii) splice defaults to using temp pages and writeback for non-temp
pages get canceled if migration is initiated
    iii) skip temp pages if a sufficient enough request timeout is set

b) how to support large FUSE folios for writeback. Currently FUSE uses
an rb tree to track writeback state of temp pages but with large
folios, this gets unsustainable if concurrent writebacks happen on the
same page indices but are part of different sized folios, eg the
following scenario
      i)  writeback on a large folio is issued
     ii) the folio is copied to a tmp folio and writeback is cleared,
we add this writeback request to the rb tree
     iii) the folio in the pagecache is evicted
     iv) another write occurs on a larger range that encompasses the
range in the writeback in i) or on a subset of it
It seems likely that we will need to align on another data structure
instead of the rb tree to sufficiently handle this.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-5-joannelko=
ong@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelko=
ong@gmail.com/

