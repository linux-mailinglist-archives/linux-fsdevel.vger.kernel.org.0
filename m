Return-Path: <linux-fsdevel+bounces-10886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B525484F275
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98001C24597
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB1267C5B;
	Fri,  9 Feb 2024 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b="jpFo3RVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93E679FE;
	Fri,  9 Feb 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471738; cv=none; b=ISZrBkDKoKuH7LA8sxMsCeZn52/PejX43JDA9bd/x6ZBk0e1d6b+xGvVqApvmmmjaHWlyAF2xfQVlK4LzKJtp3CGbpFNYYxEnZnR/rudRt63I0kU86NSy5O8BRqHbjd5TaqwkYWYVPG8okG0+L1hxhNMluGW8FTwmgAniBJRHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471738; c=relaxed/simple;
	bh=VpbPPD2abpD/atAVzzmAsiRhcyN5uyakVD9kGT25DM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0KQ1rQGGeXK3ptZiaMnDifyZVYqKSLCJ/HrT1g2YE/a2DoFFQlE6OGvSvYGkAqjXFT3ac5GRsXz4LGQMROKuf3kEVy4JtMd2qdxIRST+o2n7n01vExJ4UjToKYv4KoctDUIrjqa8DIhG/QPso1TAifbS7bkNFQtcwpDPZ9N/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de; spf=pass smtp.mailfrom=rd10.de; dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b=jpFo3RVz; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rd10.de
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4TWTQh6rnlz42xT;
	Fri,  9 Feb 2024 10:42:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rd10.de; s=key2;
	t=1707471725; bh=VpbPPD2abpD/atAVzzmAsiRhcyN5uyakVD9kGT25DM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jpFo3RVz03t+mf4FQsAqZyZCLFr4Dh8llvo3/zRq4OZSK7LkRpBoQ9rQ6Fj+HbLB8
	 sNswweQF4rqQODV6CUv/tQn135LdM77DFWQEURLtNm7eMYz5frxc91VGuk3xXP+eOw
	 kQVTJJdRHqcm7MnPcrb/G1y17sUYWIo6hw+9beohbcyZdHyAoxD6M9jT72Dlt1ZDED
	 xZSyflNjTx1SNuTi3bNg4EUgR861cgRS0drRvkr5n6cCyLCbH43RhsOqmW1k6k+6cP
	 kHZLUPwHcuD0Ow2JvUce6eH6f3/orcnk/qKy0AcZOIIWbLK0EV9HQ5DUXr4nBVU2eM
	 fC/d7HlG/vxpA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4TWTQh6TBLz7wVm;
	Fri,  9 Feb 2024 10:42:04 +0100 (CET)
Received: from mx2eb1.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4TWTQg2mFpz8sbF;
	Fri,  9 Feb 2024 10:42:03 +0100 (CET)
Received: from [IPV6:2003:cf:cf12:7800:df32:47f6:a74f:aa6f] (p200300cfcf127800df3247f6a74faa6f.dip0.t-ipconnect.de [IPv6:2003:cf:cf12:7800:df32:47f6:a74f:aa6f])
	by mx2eb1.netcup.net (Postfix) with ESMTPSA id 9D8E41016DF;
	Fri,  9 Feb 2024 10:41:58 +0100 (CET)
Authentication-Results: mx2eb1;
        spf=pass (sender IP is 2003:cf:cf12:7800:df32:47f6:a74f:aa6f) smtp.mailfrom=rdiez-2006@rd10.de smtp.helo=[IPV6:2003:cf:cf12:7800:df32:47f6:a74f:aa6f]
Received-SPF: pass (mx2eb1: connection is authenticated)
Message-ID: <617c148c-4a18-49b4-974a-18f1f500358e@rd10.de>
Date: Fri, 9 Feb 2024 10:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
Content-Language: en-GB, es
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>
References: 
 <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com>
 <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
 <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
 <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com>
 <CAH2r5mvzyxP7vHQVcT6ieP4NmXDAz2UqTT7G4yrxcVObkV_3YQ@mail.gmail.com>
 <CAKAwkKuJvFDFG7=bCYmj0jdMMhYTLUnyGDuEAubToctbNqT5CQ@mail.gmail.com>
 <CAH2r5mt9gPhUSka56yk28+nksw7=LPuS4VAMzGQyJEOfcpOc=g@mail.gmail.com>
 <CAKAwkKsm3dvM_zGtYR8VHzHyA_6hzCie3mhA4gFQKYtWx12ZXw@mail.gmail.com>
From: "R. Diez" <rdiez-2006@rd10.de>
In-Reply-To: 
 <CAKAwkKsm3dvM_zGtYR8VHzHyA_6hzCie3mhA4gFQKYtWx12ZXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <170747171908.17604.5646654263356021088@mx2eb1.netcup.net>
X-Rspamd-Queue-Id: 9D8E41016DF
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: CT6WUtMWv2WOJl+6yF1RJndA/4CnXC/crGMNg0fY

Hallo Matthew:

> [...]
> If the user does set their own "wsize", any value that is not a multiple of
> PAGE_SIZE is dangerous right? Shouldn't we prevent the user from corrupting
> their data (un)intentionally if they happen to specify a wrong value?

I already pointed that out in my e-mail dated 07.02.24 together with other potential issues:

https://www.spinics.net/lists/linux-cifs/msg30973.html

I'll recap here:

1) If the user specifies a wsize which is not multiple of PAGE_SIZE, I would abort, instead of issuing a warning. Like you said, it's too risky, you will corrupt data and you may not see the warning in an automated environment where connections are scripted.

2) Whether error or warning, I would state in the message that this is a temporary limitation. This "fix", which is more of a work-around, will probably be used for years, and people are going to think that the multiple of PAGE_SIZE is a permanent limitation in the client or the SMB protocol, which is not the case.

3) I am worried that, if the server states 60 KiB, and the CIFS client rounds it up to 64 KiB, then the connection will no longer work, because the CIFS client is exceeding the maximum that the server stated.

I wouldn't warn, I would just abort the connection in this case too.

With an old Windows Server and a page size of 64 KiB (like some ARM architecture already has), it is no longer an unlikely scenario, it will certainly occur. In my case, the connection negotiated a wsize of 16580, even though the server should actually default to 16644 bytes(?). In any case, well below 64 KiB.


Now that I mentioned misleading messages: The man page for mount.cifs, parameters rsize and wsize, talks about "maximum amount of data the kernel will request", and about the "maximum size that servers will accept". It is not clear that this is a maximum value for the negotiation phase, so 1) you do not have to worry about setting it too high on the Linux client, as the server will not reject it but negotiate it down if necessary (is that true?), and 2) the negotiation result may actually be much lower than the value you requested, but that is fine, as it wasn't really a hard request, but a soft petition.

I suggest that you guys rephrase that man page, in order to prevent other people scratching their heads again.

I would write something along this line: "Maximum amount of data that the kernel will negotiate for read [or write] requests in bytes. Maximum size that servers will negotiate is typically ...".

By the way, the current option naming is quite misleading too. I am guessing that you can specify "wsize=xxx" and then "mount -l" will show "wsize=yyy", leaving you wondering why your value was not actually taken. Or, like it happened this time, other people automatically assume that I specified a wsize, when I didn't. I would have called these parameters "maxwsize" and "negotiatedwsize", to make the distinction clear. I wonder if it is not too late to change the name of the one listed by "mount -l", that is, the "negotiatedwsize".

Regards,
   rdiez


