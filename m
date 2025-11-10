Return-Path: <linux-fsdevel+bounces-67696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52EC47528
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085CB189190B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9C9314A69;
	Mon, 10 Nov 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xz60gTbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389F31353E
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786072; cv=none; b=JJACbuer55b9j8lRdWZ8N5P433IIxycJpKgTdQpdZ6AZgpdO8SlXENF3HKP3Yvl6ljaJ4LVTJDGJhE8/E5rRoIZt5qx2FytME+U50bCrhiDUpynfEld6FXYwBxdpnZj5q7ngm202r7e95910Mg0Iy4hccU9taNprHTIfDy+tLLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786072; c=relaxed/simple;
	bh=dgdLTnC9OagC7TcCvigEKRgst8vGqHZqM0+amuk2YAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9aeYYkzBsbLrQhi0/TPAHIkylzSLgiEty1Pyb88ewYAz3HXJq0WF9Y2Op9wZDGj+P3/7zKZPyI1uBUcq604aj95oC8UGPsYnnepXoO+tuu8zmm50VYKswz42IYe+CABG938pHhsJSV/Y7ymYAzHLEKtPtXJMmnvmvG9xU6wJGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xz60gTbZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762786069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIeb35oP9Vs/R5h7VhglPZyEdkMXH/upLLEanGBOeTA=;
	b=Xz60gTbZggctvqMyRadIH86E6OfzXHAsxNMqqOU12nBpvcWc6S9JiRDMGTh7lHuhWHLHhL
	JxpNq7hVIKTmn5n38THhHP3C7D0aNhW3KRSkji32ICuFPUKXN4lN1WgevmtMeDICw2DETm
	zMBNt6EfEdBzKBGDQQa7Mdy8JoFnfmg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-b2a0058xO8GOujbU21T91g-1; Mon,
 10 Nov 2025 09:47:36 -0500
X-MC-Unique: b2a0058xO8GOujbU21T91g-1
X-Mimecast-MFC-AGG-ID: b2a0058xO8GOujbU21T91g_1762786050
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49CC218002CB;
	Mon, 10 Nov 2025 14:47:28 +0000 (UTC)
Received: from fedora (unknown [10.44.33.158])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 787811800451;
	Mon, 10 Nov 2025 14:47:08 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Nov 2025 15:47:27 +0100 (CET)
Date: Mon, 10 Nov 2025 15:47:06 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Levin <ldv@strace.io>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Adrian Reber <areber@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	tiozhang <tiozhang@didiglobal.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	YueHaibing <yuehaibing@huawei.com>,
	Paul Moore <paul@paul-moore.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>,
	xu xin <xu.xin16@zte.com.cn>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Liljestrand <ishkamiel@gmail.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC PATCH 0/3] mt-exec: fix deadlock with ptrace_attach()
Message-ID: <aRH66lGd-OT4O68C@redhat.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <aRDL3HOB21pMVMWC@redhat.com>
 <GV2PPF74270EBEE83C2CA09B945BC954FA3E4CEA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PPF74270EBEE83C2CA09B945BC954FA3E4CEA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Bernd,

On 11/10, Bernd Edlinger wrote:
>
> When the debugger wants to attach the de_thread the debug-user access rights are
> checked against the current user and additionally against the new user credentials.
> This I did by quickly switching the user credenitals to the next user and back again,
> under the cred_guard_mutex, which should make that safe.

Let me repeat, I can't really comment this part, I don't know if it is
actually safe. But the very fact your patch changes ->mm and ->cred of
the execing task in ptrace_attach() makes me worry... At least I think
you should update or remove this comment in begin_new_exec:

	/*
	 * cred_guard_mutex must be held at least to this point to prevent
	 * ptrace_attach() from altering our determination of the task's
	 * credentials; any time after this it may be unlocked.
	 */
	security_bprm_committed_creds(bprm);

> So at this time I have only one request for you.
> Could you please try out how the test case in my patch behaves with your fix?

The new TEST(attach2) added by your patch fails as expected, see 3/3.

   128  static long thread2_tid;
   129  static void *thread2(void *arg)
   130  {
   131          thread2_tid = syscall(__NR_gettid);
   132          sleep(2);
   133          execlp("false", "false", NULL);
   134          return NULL;
   135  }
   136
   137  TEST(attach2)
   138  {
   139          int s, k, pid = fork();
   140
   141          if (!pid) {
   142                  pthread_t pt;
   143
   144                  pthread_create(&pt, NULL, thread2, NULL);
   145                  pthread_join(pt, NULL);
   146                  return;
   147          }
   148
   149          sleep(1);
   150          k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
   151          ASSERT_EQ(k, 0);
   152          k = waitpid(-1, &s, 0);
   153          ASSERT_EQ(k, pid);
   154          ASSERT_EQ(WIFSTOPPED(s), 1);
   155          ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
   156          k = ptrace(PTRACE_SETOPTIONS, pid, 0L, PTRACE_O_TRACEEXIT);
   157          ASSERT_EQ(k, 0);
   158          thread2_tid = ptrace(PTRACE_PEEKDATA, pid, &thread2_tid, 0L);
   159          ASSERT_NE(thread2_tid, -1);
   160          ASSERT_NE(thread2_tid, 0);
   161          ASSERT_NE(thread2_tid, pid);
   162          k = waitpid(-1, &s, WNOHANG);
   163          ASSERT_EQ(k, 0);
   164          sleep(2);
   165          /* deadlock may happen here */
   166          k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);

PTRACE_ATTACH fails.

thread2() kills the old leader, takes it pid, execlp() succeeds.

Oleg.


