Return-Path: <linux-fsdevel+bounces-8159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F4830733
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 14:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98261B24309
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11551200D2;
	Wed, 17 Jan 2024 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DEGHyY+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB3A1F5F7;
	Wed, 17 Jan 2024 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498668; cv=none; b=B5KUoLOVCVYA5pMy2KmFwPP4p0lXo3GI6jLEgDu6c+Qnyqtm6MOk52NCwx+x8ZH5dmhf+aAcvpVEhAZFzkkUHEbrpk5+BEfeUPzvZVe5l9zksSNVIIzsDyKW8/UiQVLkhAJ9zWKJZ0nJ0EIeVoQT/XKfPhMgja1OSnt3RvtUQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498668; c=relaxed/simple;
	bh=a0o55pxxDCLHmqaWvxrygvI6niPdHttBqY/E85EhHew=;
	h=DKIM-Signature:Received:Received:Subject:From:To:Cc:References:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Language:Content-Transfer-Encoding:X-Authenticated-Sender:
	 X-Virus-Scanned; b=iKGkQOtampxcIClUmVv8tX3N9MbzIz200z1UJvn0ZLjNfPJLpz41xXGqpbXT74z6ZMVPQpV3o72bMqteDzZ3vsTiWi7FNTxwgDy0eNnll+oZwwSfHX7gayt1DdL9kdA2Cm1xYnZm4hb3chfsyOBHhUpGceIp5naUw2nSzVBy+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DEGHyY+4; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EUpvZ7ImcN6iRBfQR5QrQA+ZGjPdmy3aiW0Hd3hcrnQ=; b=DEGHyY+49LEH3JYxGgz1hw+W01
	u8ZPQ5hafPlp6u04J2wN52hOOGCB3BQLSYBSxcAeo1w+RKoiyUBhGnNg0Sz3l5VCByCNn+JzxzsIr
	5HU91Q3fKkxhIEhuZIxOnJzyqJvtzz3JDCJ143149F0dx/695qfuSJZIb6uncyA0Eszq9kdWqY5Us
	DAISHVTJ3azdLRkAb+v7THDFfp3dk5oROIAFY3mDvTU26s7HwXOMao46pD6RbkTRBlR/0pTXv13JB
	PQunZBTeSUjfhN1b9tPLnHan9qvIDeOhXeDJ/0y9/C0aVlrREfowX/rZRib95Gc/G2nqY0SVSd1LD
	2mWUk//Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rQ66w-000ExX-1L; Wed, 17 Jan 2024 14:37:42 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rQ66v-000EvW-F7; Wed, 17 Jan 2024 14:37:41 +0100
Subject: LSF/MM/BPF: 2024: Call for Proposals [Reminder]
From: Daniel Borkmann <daniel@iogearbox.net>
To: lsf-pc@lists.linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
Message-ID: <c91530f0-2688-647d-2603-a7b1673f8e42@iogearbox.net>
Date: Wed, 17 Jan 2024 14:37:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27157/Wed Jan 17 10:41:11 2024)

The annual Linux Storage, Filesystem, Memory Management, and BPF
(LSF/MM/BPF) Summit for 2024 will be held from May 13 to May 15
at the Hilton Salt Lake City Center in Salt Lake City, Utah, USA.

LSF/MM/BPF is an invitation-only technical workshop to map out
improvements to the Linux storage, filesystem, BPF, and memory
management subsystems that will make their way into the mainline
kernel within the coming years.

LSF/MM/BPF 2024 will be a three day, stand-alone conference with
four subsystem-specific tracks, cross-track discussions, as well
as BoF and hacking sessions:

          https://events.linuxfoundation.org/lsfmmbpf/

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please
point that out in your proposal or request to attend, and submit
the topic as soon as possible.

We are asking that you please let us know you want to be invited
by March 1, 2024. We realize that travel is an ever changing target,
but it helps us to get an idea of possible attendance numbers.
Clearly things can and will change, so consider the request to
attend deadline more about planning and less about concrete plans.

1) Fill out the following Google form to request attendance and
suggest any topics for discussion:

          https://forms.gle/TGCgBDH1x5pXiWFo7

In previous years we have accidentally missed people's attendance
requests because they either did not Cc lsf-pc@ or we simply missed
them in the flurry of emails we get. Our community is large and our
volunteers are busy, filling this out will help us to make sure we
do not miss anybody.

2) Proposals for agenda topics should ideally still be sent to the
following lists to allow for discussion among your peers. This will
help us figure out which topics are important for the agenda:

          lsf-pc@lists.linux-foundation.org

... and Cc the mailing lists that are relevant for the topic in
question:

          FS:     linux-fsdevel@vger.kernel.org
          MM:     linux-mm@kvack.org
          Block:  linux-block@vger.kernel.org
          ATA:    linux-ide@vger.kernel.org
          SCSI:   linux-scsi@vger.kernel.org
          NVMe:   linux-nvme@lists.infradead.org
          BPF:    bpf@vger.kernel.org

Please tag your proposal with [LSF/MM/BPF TOPIC] to make it easier
to track. In addition, please make sure to start a new thread for
each topic rather than following up to an existing one. Agenda
topics and attendees will be selected by the program committee,
but the final agenda will be formed by consensus of the attendees
on the day.

3) This year we would also like to try and make sure we are
including new members in the community that the program committee
may not be familiar with. The Google form has an area for people to
add required/optional attendees. Please encourage new members of the
community to submit a request for an invite as well, but additionally
if maintainers or long term community members could add nominees to
the form it would help us make sure that new members get the proper
consideration.

For discussion leaders, slides and visualizations are encouraged to
outline the subject matter and focus the discussions. Please refrain
from lengthy presentations and talks in order for sessions to be
productive; the sessions are supposed to be interactive, inclusive
discussions.

We are still looking into the virtual component. We will likely run
something similar to what we did last year, but details on that will
be forthcoming.

2023: https://lwn.net/Articles/lsfmmbpf2023/

2022: https://lwn.net/Articles/lsfmm2022/

2019: https://lwn.net/Articles/lsfmm2019/

2018: https://lwn.net/Articles/lsfmm2018/

2017: https://lwn.net/Articles/lsfmm2017/

2016: https://lwn.net/Articles/lsfmm2016/

2015: https://lwn.net/Articles/lsfmm2015/

2014: http://lwn.net/Articles/LSFMM2014/

4) If you have feedback on last year's meeting that we can use to
improve this year's, please also send that to:

          lsf-pc@lists.linux-foundation.org

Thank you on behalf of the program committee:

          Amir Goldstein (Filesystems)
          Jan Kara (Filesystems)
          Martin K. Petersen (Storage)
          Javier González (Storage)
          Michal Hocko (MM)
          Dan Williams (MM)
          Daniel Borkmann (BPF)
          Martin KaFai Lau (BPF)

