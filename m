Return-Path: <linux-fsdevel+bounces-67930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6D0C4E0F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 514E434EABC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C993331200;
	Tue, 11 Nov 2025 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhK/Urp5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957533121E
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866785; cv=none; b=fStAm7ZcxisDG8JSv3qvIbWpXrLhMYiQCiLrt2/c6sQLPG8tjw1UX2GmtXzE1VL+biksD6JjIxm7ieqnmoyDGMCrmjzmKwirSSEA7sEMmQWIvB+QcY9vyvZtrO8685kSR3IdP7MIkTCKSEsFntUWdkO0etcahDsiJHwEyB5ffDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866785; c=relaxed/simple;
	bh=ZQiYZa+UMJ28kPPzr7A5LUc/D3pE1z5z0fBFkzoygMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skX9j2Fgo49ns4RUho7m3Bn6RjEumRZHmXYsBS2CCpMa17Mg07tCXS+9+D60XLB9h7NL2tpcqKcime1P4Lfp1IGZW5Cm4I26JJNdiAwaozhY/RZ1fKF/e6uAcvqp0I0b3v2ee7rYnbJS+QnYBvW7OAvflaVKt5VnMcHLd7aHQGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhK/Urp5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762866783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQiYZa+UMJ28kPPzr7A5LUc/D3pE1z5z0fBFkzoygMc=;
	b=bhK/Urp5HJF7LNICVKVEYMWAgN15B8/DkiwKtOtREir0Edki99/7j7MOmmMnVXXtpEN2kk
	Xk3SwozFeNVOXzvdDocDMLY/d6AdiQ6bUHf5c2eSR1EQ25koc2Vi8nNnqQx4m1ddXzba0d
	HE7aDwBXAHIbwyJtcdSiohDWsOFrBDs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-9-RmVw9LOWG7O6AoUjelsw-1; Tue,
 11 Nov 2025 08:12:59 -0500
X-MC-Unique: 9-RmVw9LOWG7O6AoUjelsw-1
X-Mimecast-MFC-AGG-ID: 9-RmVw9LOWG7O6AoUjelsw_1762866773
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 440D51956061;
	Tue, 11 Nov 2025 13:12:50 +0000 (UTC)
Received: from fedora (unknown [10.44.33.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6E9631800872;
	Tue, 11 Nov 2025 13:12:30 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Nov 2025 14:12:49 +0100 (CET)
Date: Tue, 11 Nov 2025 14:12:28 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
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
Subject: Re: [PATCH v17] exec: Fix dead-lock in de_thread with ptrace_attach
Message-ID: <aRM2POTDTxEzeF2F@redhat.com>
References: <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <20251105143210.GA25535@redhat.com>
 <20251111-ankreiden-augen-eadcf9bbdfaa@brauner>
 <GV2PPF74270EBEEDCF80CEE0F08891ED37BE4CFA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PPF74270EBEEDCF80CEE0F08891ED37BE4CFA@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 11/11, Bernd Edlinger wrote:
>
> On 11/11/25 10:21, Christian Brauner wrote:
> > On Wed, Nov 05, 2025 at 03:32:10PM +0100, Oleg Nesterov wrote:
> >>
> >> This is the most problematic change which I can't review...
> >>
> >> Firstly, it changes task->mm/real_cred for __ptrace_may_access() and this
> >> looks dangerous to me.
> >
> > Yeah, that is not ok. This is effectively override_creds for real_cred
> > and that is not a pattern I want to see us establish at all! Temporary
> > credential overrides for the subjective credentials is already terrible
> > but at least we have the explicit split between real_cred and cred
> > expressely for that. So no, that's not an acceptable solution.
> >
>
> Well when this is absolutely not acceptable then I would have to change
> all security engines to be aware of the current and the new credentials.

Hmm... even if we find another way to avoid the deadlock? Say, the patches
I sent...

Oleg.


