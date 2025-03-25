Return-Path: <linux-fsdevel+bounces-44956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE29A6FAE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D111E3B1E5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8C3256C64;
	Tue, 25 Mar 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBXDoYhF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDA2254845
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904979; cv=none; b=keYrS1b4X3+VJLpX3nAKKc1PbZiKeKY43fL83zfRlm64BAfA70piBeQk0/SGLznhS21oRlcuWggnSxRU486gV8aMbzD9bHeflcyreu5vZrkX0vG0lMcRwAUvdxpvEMKGiuXljuK79LfYnu63mQgaIK0O1Lxp6MHteoOeQ5EeGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904979; c=relaxed/simple;
	bh=rI0g/BSBDaD6jBN2dk10+1Ats2Jyq+DQdGBNnf51050=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3SuNjPrBNjyeCnGwpj0A3kmC/R0WSr0S9/bxkYLF8ElZnTtdHwXYxYhfuSyABMt2bGysuImtf8MyW/o4CN73C0VoGN+9gvTow62nhXKIrMxL3I8uSEdaHNn22jwRxnDcqnckbxqxFiQkmCmfcOuBKw0/s5J+UxE1USCNqlb1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBXDoYhF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742904976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YN3nmO/9g8xSIKypuT/X1c8iSgRJbGMKCkb3s4C1n1w=;
	b=hBXDoYhFIUfOqTwpJcSukOmBnQ52NIzgUeMzaNGPR/P3tv83CjTC27KP10k9t5rEab/VGr
	AB2Nqa6GiLezCBYjS855Ei8lL/jR1dL0UrZHorHpju+5cqCDH3iBOEAr8CHv4eTFbGfeFV
	GcSm7KIYksnUGx7xXTAgyx3S1VDUvC0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-4mqSlZdnPOGa4-9RQ6te9g-1; Tue,
 25 Mar 2025 08:16:11 -0400
X-MC-Unique: 4mqSlZdnPOGa4-9RQ6te9g-1
X-Mimecast-MFC-AGG-ID: 4mqSlZdnPOGa4-9RQ6te9g_1742904968
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C87FD196D2D2;
	Tue, 25 Mar 2025 12:16:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E41941956095;
	Tue, 25 Mar 2025 12:16:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 25 Mar 2025 13:15:34 +0100 (CET)
Date: Tue, 25 Mar 2025 13:15:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>,
	brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
	swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk, v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <20250325121526.GA7904@redhat.com>
References: <20250323184848.GB14883@redhat.com>
 <67e05e30.050a0220.21942d.0003.GAE@google.com>
 <20250323194701.GC14883@redhat.com>
 <CAGudoHHmvU54MU8dsZy422A4+ZzWTVs7LFevP7NpKzwZ1YOqgg@mail.gmail.com>
 <20250323210251.GD14883@redhat.com>
 <af0134a7-6f2a-46e1-85aa-c97477bd6ed8@amd.com>
 <CAGudoHH9w8VO8069iKf_TsAjnfuRSrgiJ2e2D9-NGEDgXW+Lcw@mail.gmail.com>
 <7e377feb-a78b-4055-88cc-2c20f924bf82@amd.com>
 <f7585a27-aaef-4334-a1de-5e081f10c901@amd.com>
 <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff294b3c-cd24-4aa6-9d03-718ff7087158@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Prateek, thanks again for your hard work!

Yes, I think we need the help from 9p folks. I know nothing about it, but
so far this still looks as a 9p problem to me...

All I can say right now is that the "sigpending" logic in p9_client_rpc()
looks wrong. If nothing else:

	- clear_thread_flag(TIF_SIGPENDING) is not enough, it won't make
	  signal_pending() false if TIF_NOTIFY_SIGNAL is set.

	- otoh, if signal_pending() was true because of pending SIGKILL,
	  then after clear_thread_flag(TIF_SIGPENDING) wait_event_killable()
	  will act as uninterruptible wait_event().

Oleg.

On 03/25, K Prateek Nayak wrote:
>
> On 3/24/2025 8:22 PM, K Prateek Nayak wrote:
> >Hello folks,
> >
> >Some updates.
> >
> >On 3/24/2025 6:49 PM, K Prateek Nayak wrote:
> >>>
> >>>Per syzbot this attempt did not work out either.
> >>>
> >>>I think the blind stabs taken by everyone here are enough.
> >>>
> >>>The report does not provide the crucial bit: what are the other
> >>>threads doing. Presumably someone else is stuck somewhere, possibly
> >>>not even in pipe code and that stuck thread was supposed to wake up
> >>>the one which trips over hung task detector. Figuring out what that
> >>>thread is imo the next step.
> >>>
> >>>I failed to find a relevant command in
> >>>https://github.com/google/syzkaller/blob/master/docs/syzbot.md
> >>>
> >>>So if you guys know someone on syzkaller side, maybe you can ask them
> >>>to tweak the report *or* maybe syzbot can test a "fix" which makes
> >>>hung task detector also report all backtraces? I don't know if that
> >>>can work, the output may be long enough that it will get trimmed by
> >>>something.
> >>>
> >>>I don't have to time work on this for now, just throwing ideas.
> >>
> >>I got the reproducer running locally. Tracing stuff currently to see
> >>what is tripping. Will report back once I find something interesting.
> >>Might take a while since the 9p bits are so far spread out.
> >>
> >
> >So far, with tracing, this is where I'm:
> >
> >o Mainline + Oleg's optimization reverted:
> >
> >     ...
> >     kworker/43:1-1723    [043] .....   115.309065: p9_read_work: Data read wait 55
> >     kworker/43:1-1723    [043] .....   115.309066: p9_read_work: Data read 55
> >     kworker/43:1-1723    [043] .....   115.309067: p9_read_work: Data read wait 7
> >     kworker/43:1-1723    [043] .....   115.309068: p9_read_work: Data read 7
> >            repro-4138    [043] .....   115.309084: netfs_wake_write_collector: Wake collector
> >            repro-4138    [043] .....   115.309085: netfs_wake_write_collector: Queuing collector work
> >            repro-4138    [043] .....   115.309088: netfs_unbuffered_write: netfs_unbuffered_write
> >            repro-4138    [043] .....   115.309088: netfs_end_issue_write: netfs_end_issue_write
> >            repro-4138    [043] .....   115.309089: netfs_end_issue_write: Write collector need poke 0
> >            repro-4138    [043] .....   115.309091: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
> >  kworker/u1030:1-1951    [168] .....   115.309096: netfs_wake_write_collector: Wake collector
> >  kworker/u1030:1-1951    [168] .....   115.309097: netfs_wake_write_collector: Queuing collector work
> >  kworker/u1030:1-1951    [168] .....   115.309102: netfs_write_collection_worker: Write collect clearing and waking up!
> >     ... (syzbot reproducer continues)
> >
> >o Mainline:
> >
> >    kworker/185:1-1767    [185] .....   109.485961: p9_read_work: Data read wait 7
> >    kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data read 7
> >    kworker/185:1-1767    [185] .....   109.485962: p9_read_work: Data read wait 55
> >    kworker/185:1-1767    [185] .....   109.485963: p9_read_work: Data read 55
> >            repro-4038    [185] .....   114.225717: netfs_wake_write_collector: Wake collector
> >            repro-4038    [185] .....   114.225723: netfs_wake_write_collector: Queuing collector work
> >            repro-4038    [185] .....   114.225727: netfs_unbuffered_write: netfs_unbuffered_write
> >            repro-4038    [185] .....   114.225727: netfs_end_issue_write: netfs_end_issue_write
> >            repro-4038    [185] .....   114.225728: netfs_end_issue_write: Write collector need poke 0
> >            repro-4038    [185] .....   114.225728: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
> >    ... (syzbot reproducer hangs)
> >
> >There is a third "kworker/u1030" component that never gets woken up for
> >reasons currently unknown to me with Oleg's optimization. I'll keep
> >digging.
>
> More data ...
>
> I chased this down to p9_client_rpc() net/9p/client.c specifically:
>
>         err = c->trans_mod->request(c, req);
>         if (err < 0) {
>                 /* write won't happen */
>                 p9_req_put(c, req);
>                 if (err != -ERESTARTSYS && err != -EFAULT)
>                         c->status = Disconnected;
>                 goto recalc_sigpending;
>         }
>
> c->trans_mod->request() calls p9_fd_request() in net/9p/trans_fd.c
> which basically does a p9_fd_poll().
>
> Previously, the above would fail with err as -EIO which would
> cause the client to "Disconnect" and the retry logic would make
> progress. Now however, the err returned is -ERESTARTSYS which
> will not cause a disconnect and the retry logic will hang
> somewhere in p9_client_rpc() later.
>
> I'll chase it a little more but if 9p folks can chime in it would
> be great since I'm out of my depths here.
>
> P.S. There are more interactions at play and I'm trying to still
> piece them together.
>
> Relevant traces:
>
> o Mainline + Oleg's optimization reverted:
>
>            repro-4161    [239] .....   107.785644: p9_client_write: p9_client_rpc done
>            repro-4161    [239] .....   107.785644: p9_client_write: p9_pdup
>            repro-4161    [239] .....   107.785644: p9_client_write: iter revert
>            repro-4161    [239] .....   107.785644: p9_client_write: p9_client_rpc
>            repro-4161    [239] .....   107.785653: p9_fd_request: p9_fd_request
>            repro-4161    [239] ...1.   107.785653: p9_fd_request: p9_fd_request error
>            repro-4161    [239] .....   107.785653: p9_client_rpc: Client disconnected (no write) <------------- "write won't happen" case
>            repro-4161    [239] .....   107.785655: p9_client_write: p9_client_rpc done
>            repro-4161    [239] .....   107.785655: p9_client_write: p9_client_rpc error (-5)     <------------- -EIO
>            repro-4161    [239] .....   107.785656: v9fs_issue_write: Issue write done 2 err(-5)
>            repro-4161    [239] .....   107.785657: netfs_write_subrequest_terminated: Collector woken up from netfs_write_subrequest_terminated
>            repro-4161    [239] .....   107.785657: netfs_wake_write_collector: Wake collector
>            repro-4161    [239] .....   107.785658: netfs_wake_write_collector: Queuing collector work
>            repro-4161    [239] .....   107.785660: v9fs_issue_write: Issue write subrequest terminated 2
>            repro-4161    [239] .....   107.785661: netfs_unbuffered_write: netfs_unbuffered_write
>            repro-4161    [239] .....   107.785661: netfs_end_issue_write: netfs_end_issue_write
>            repro-4161    [239] .....   107.785662: netfs_end_issue_write: Write collector need poke 0
>            repro-4161    [239] .....   107.785662: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
>  kworker/u1038:0-1583    [105] .....   107.785667: netfs_retry_writes: netfs_reissue_write 1
>  kworker/u1038:0-1583    [105] .....   107.785668: v9fs_issue_write: v9fs_issue_write
>  kworker/u1038:0-1583    [105] .....   107.785669: p9_client_write: p9_client_rpc
>  kworker/u1038:0-1583    [105] .....   107.785669: p9_client_prepare_req: p9_client_prepare_req eio 1
>  kworker/u1038:0-1583    [105] .....   107.785670: p9_client_rpc: p9_client_rpc early err return
>  kworker/u1038:0-1583    [105] .....   107.785670: p9_client_write: p9_client_rpc done
>  kworker/u1038:0-1583    [105] .....   107.785671: p9_client_write: p9_client_rpc error (-5)
>  kworker/u1038:0-1583    [105] .....   107.785672: v9fs_issue_write: Issue write done 0 err(-5)
>  kworker/u1038:0-1583    [105] .....   107.785672: netfs_write_subrequest_terminated: Collector woken up
>  kworker/u1038:0-1583    [105] .....   107.785672: netfs_wake_write_collector: Wake collector
>  kworker/u1038:0-1583    [105] .....   107.785672: netfs_wake_write_collector: Queuing collector work
>  kworker/u1038:0-1583    [105] .....   107.785677: v9fs_issue_write: Issue write subrequest terminated 0
>  kworker/u1038:0-1583    [105] .....   107.785684: netfs_write_collection_worker: Write collect clearing and waking up!
>            repro-4161    [239] .....   107.785883: p9_client_prepare_req: p9_client_prepare_req eio 1
>            ... (continues)
>
> o Mainline:
>
>            repro-4161    [087] .....   123.474660: p9_client_write: p9_client_rpc done
>            repro-4161    [087] .....   123.474661: p9_client_write: p9_pdup
>            repro-4161    [087] .....   123.474661: p9_client_write: iter revert
>            repro-4161    [087] .....   123.474661: p9_client_write: p9_client_rpc
>            repro-4161    [087] .....   123.474672: p9_fd_request: p9_fd_request
>            repro-4161    [087] .....   123.474673: p9_fd_request: p9_fd_request EPOLL
>            repro-4161    [087] .....   123.474673: p9_fd_poll: p9_fd_poll rd poll
>            repro-4161    [087] .....   123.474674: p9_fd_poll: p9_fd_request wr poll
>            repro-4161    [087] .....   128.233025: p9_client_write: p9_client_rpc done
>            repro-4161    [087] .....   128.233033: p9_client_write: p9_client_rpc error (-512)     <------------- -ERESTARTSYS
>            repro-4161    [087] .....   128.233034: v9fs_issue_write: Issue write done 2 err(-512)
>            repro-4161    [087] .....   128.233035: netfs_write_subrequest_terminated: Collector woken
>            repro-4161    [087] .....   128.233036: netfs_wake_write_collector: Wake collector
>            repro-4161    [087] .....   128.233036: netfs_wake_write_collector: Queuing collector work
>            repro-4161    [087] .....   128.233040: v9fs_issue_write: Issue write subrequest terminated 2
>            repro-4161    [087] .....   128.233040: netfs_unbuffered_write: netfs_unbuffered_write
>            repro-4161    [087] .....   128.233040: netfs_end_issue_write: netfs_end_issue_write
>            repro-4161    [087] .....   128.233041: netfs_end_issue_write: Write collector need poke 0
>            repro-4161    [087] .....   128.233041: netfs_unbuffered_write_iter_locked: Waiting on NETFS_RREQ_IN_PROGRESS!
>  kworker/u1035:0-1580    [080] .....   128.233077: netfs_retry_writes: netfs_reissue_write 1
>  kworker/u1035:0-1580    [080] .....   128.233078: v9fs_issue_write: v9fs_issue_write
>  kworker/u1035:0-1580    [080] .....   128.233079: p9_client_write: p9_client_rpc
>  kworker/u1035:0-1580    [080] .....   128.233099: p9_fd_request: p9_fd_request
>  kworker/u1035:0-1580    [080] .....   128.233101: p9_fd_request: p9_fd_request EPOLL
>  kworker/u1035:0-1580    [080] .....   128.233101: p9_fd_poll: p9_fd_poll rd poll
>  kworker/u1035:0-1580    [080] .....   128.233101: p9_fd_poll: p9_fd_request wr poll
>            (Hangs)
>
> --
> Thanks and Regards,
> Prateek
>


