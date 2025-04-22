Return-Path: <linux-fsdevel+bounces-47000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA3A97636
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 21:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3331892029
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 19:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57D7298CC7;
	Tue, 22 Apr 2025 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRvUNoMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA020D4F6
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351631; cv=none; b=UYrJ+7rnQX/dc322iJhfQriPrtMlshZpoqEngPgEJ6IYuqVBDrd0X+RnPPVcKH6d9cAMApVTKu/Ep9aSXwWKadhcCpxUNKz0Ts/PGoWdNN2fDBcspnbeM0rWZFHxn21TcSLGqR7cKWg2XD3uDct/eW3pmOXOH1jZ0MSSA9rFeIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351631; c=relaxed/simple;
	bh=mgUI3KZhX/GLZrZ+n9B0MRmr/QJm+2Au8qoCGXjlnpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxUlLpRtEobn1fJA28z2aO2hJr6PUXKKIIcmQEPtCYMSsFr12iq+F0c0RLCUkjtG4gxoyXiCMLixu3SG+8DaXk6gH3H8waiRaI+m2VFDechZR+GJimccYB9ecHCrCmfrPRz+MUPoA0SXWKlKVStmDBUKKDCOdpjlw57q/sfaO1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRvUNoMn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745351628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=guuXjMeQDHoW1XS3M894x+TmtOB1toyTlu9Qd/Rij4M=;
	b=SRvUNoMnQ7Bn2yOprT4pDiI4nc6BQ3xIPCq5JQpmdZ0nmHRbPvs+9l6Pb3lrC1fpCoDD4y
	68q9eb+/4myLjl8D6BFS+0cP56PjmhYQ1Lvdh2eG2IdKtdduarR406DhIg+yzGZJovAqaL
	tl2ooXPOtKBE8JbebkZxLxMdU/X+BCw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-GMJdIDJGPrGfT_7h02K7pQ-1; Tue, 22 Apr 2025 15:53:45 -0400
X-MC-Unique: GMJdIDJGPrGfT_7h02K7pQ-1
X-Mimecast-MFC-AGG-ID: GMJdIDJGPrGfT_7h02K7pQ_1745351625
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5e28d0cc0so954230585a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 12:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745351625; x=1745956425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guuXjMeQDHoW1XS3M894x+TmtOB1toyTlu9Qd/Rij4M=;
        b=umy4KADDUqgeI0DoJVaLqLDGCP2vBp8QUHIBRoW+35KfDGgIFN+HhoyrENq9yG8c9B
         tXe4SsWeY3vGzHhpkoxBIy8/oWOgLrYbEm1T4O8foYKPNesDORIPjfSRUJSfnjFITRhv
         P2cfIOAOw+qw31d/LPOj6s++bpT1ON4D3Dac92zbATL+HWOri5U/GwkimQuUXCCN8+BK
         EAf5z1K7UaL97z3d650Vd2SiUHJBfzii8CBtfXRKrNnmMPoSabOLYIC/9PxogN6qakOY
         GX2ArB8Yy82bES6G4y3nUAUw+Rh/3E+zpwPmW74d8RrPYFsE1z8S8oLY0pOSO2EO0nNO
         7Sxw==
X-Forwarded-Encrypted: i=1; AJvYcCWZNNpNsdl6EExwbUVwAmaGY83E/ZUfegYQ1J2WIdhNpbWkXr4KcDiutQVtuHHaWa8e0d1NUffJ0wLXh1KV@vger.kernel.org
X-Gm-Message-State: AOJu0YxtlU6zlz0EYIej8aWFLvz8YOVauP6dGvEu2nQUrN8d7tCCrPty
	qndnRVl77UIHVGOFq47dH8FvWtkcHRG8UD/SwqTY2lnffbGmzMLoM2+TSlOuSnhMXQ9UARqXNcX
	2G3oDEkAeP1FRZHf0RmDZsnTDD6ozyMbp7I1EoJaUrZg7JM4bCIE8ds8jWVU9qpQ=
X-Gm-Gg: ASbGnctONSanA5s82YOWABAdcnxCS74+xNbpuORS30lV0m36MXwjCcJVjh8vX+LZgWb
	3+zLVf+ATya3ELr3vmxVjHt2/STe+yaURewumoGisdyYdi2+5YeSrZBXaCBFfw8sckNaKeFpF/I
	IJEsRgAqVg5XsYeaoUDJtNvFd9YoK/jjBW6wUDMKDT7gIrUIqtUE/SGXePcYj2i0QLg7kketlcI
	IEO8C63ZhmA9bbDQxKbK4WPNVRkCK/E38CbNVDFKE/u4KsZM4HK3c+J4qmVwuFIf+mdu1S6z6q4
	Ywkurno0D2ySO6s8XsWLS3/8xSbUCmcoOzvcN93Er3p5cq3/AM+1UHg=
X-Received: by 2002:a05:620a:318f:b0:7c7:5a9f:7a90 with SMTP id af79cd13be357-7c927f6b66emr2706873285a.4.1745351625196;
        Tue, 22 Apr 2025 12:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX0sH43iwr9p6/LRXrPyohHGTeLO7bLREMgSdAMcE23hvDtCxv531dfovueZkEjPMtL6eeHw==
X-Received: by 2002:a05:620a:318f:b0:7c7:5a9f:7a90 with SMTP id af79cd13be357-7c927f6b66emr2706869685a.4.1745351624778;
        Tue, 22 Apr 2025 12:53:44 -0700 (PDT)
Received: from localhost (pool-100-17-21-114.bstnma.fios.verizon.net. [100.17.21.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8d2e0sm591969685a.36.2025.04.22.12.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:53:44 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:53:43 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <fzqxqmlhild55m7lfrcdjikkuapi3hzulyt66d6xqdfhz3gjft@cimjdcqdc62n>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250420055406.GS2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420055406.GS2023217@ZenIV>

On Sun, Apr 20, 2025 at 06:54:06AM +0100, Al Viro wrote:
> On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
> > Defer releasing the detached file-system when calling namespace_unlock()
> > during a lazy umount to return faster.
> > 
> > When requesting MNT_DETACH, the caller does not expect the file-system
> > to be shut down upon returning from the syscall.
> 
> Not quite.  Sure, there might be another process pinning a filesystem;
> in that case umount -l simply removes it from mount tree, drops the
> reference and goes away.  However, we need to worry about the following
> case:
> 	umount -l has succeeded
> 	<several minutes later>
> 	shutdown -r now
> 	<apparently clean shutdown, with all processes killed just fine>
> 	<reboot>
> 	WTF do we have a bunch of dirty local filesystems?  Where has the data gone?
> 
> Think what happens if you have e.g. a subtree with several local filesystems
> mounted in it, along with an NFS on a slow server.  Or a filesystem with
> shitloads of dirty data in cache, for that matter.
> 
> Your async helper is busy in the middle of shutting a filesystem down, with
> several more still in the list of mounts to drop.  With no indication for anyone
> and anything that something's going on.
> 

I'm not quite following. With umount -l, I thought there is no guaranty
that the file-system is shutdown. Doesn't "shutdown -r now" already
risks loses without any of these changes today? Or am I missing your
point entirely? It looks like the described use-case in umount(8)
manpage.

> umount -l MAY leave filesystem still active; you can't e.g. do it and pull
> a USB stick out as soon as it finishes, etc.  After all, somebody might've
> opened a file on it just as you called umount(2); that's expected behaviour.
> It's not fully async, though - having unobservable fs shutdown going on
> with no way to tell that it's not over yet is not a good thing.
> 
> Cost of synchronize_rcu_expedited() is an issue, all right, and it does
> feel like an excessively blunt tool, but that's a separate story.  Your
> test does not measure that, though - you have fs shutdown mixed with
> the cost of synchronize_rcu_expedited(), with no way to tell how much
> does each of those cost.
> 
> Could you do mount -t tmpfs tmpfs mnt; sleep 60 > mnt/foo &
> followed by umount -l mnt to see where the costs are?

I was under the impression the tests provided did not account for the
file-system shutdown, or that it was negligible.

The following, on mainline PREEMPT_RT, without any patch mentioned
before?

 # mount -t tmpfs tmpfs mnt; sleep 60 > mnt/foo &
     perf ftrace -G path_umount --graph-opts="depth=4" umount -l /mnt/
[Eliding most calls <100us]
 0)               |  path_umount() {
 [...]
 0)               |    namespace_unlock() {
 [...]
 0)               |      synchronize_rcu_expedited() {
 0)   0.108 us    |        rcu_gp_is_normal();
 0)               |        synchronize_rcu_normal() {
 0) * 15820.29 us |        }
 0) * 15829.52 us |      }
 [...]
 0) * 15852.90 us |    }
 [...]
 0) * 15918.07 us |  }

Thanks,

-- 
Eric Chanudet


