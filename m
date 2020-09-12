Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB62267B0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 16:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgILOvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 10:51:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:40796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgILOrb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 10:47:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EB33AB91;
        Sat, 12 Sep 2020 14:47:41 +0000 (UTC)
Date:   Sat, 12 Sep 2020 15:47:22 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     John Wood <john.wood@gmx.com>
Cc:     James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RESEND][RFC PATCH 0/6] Fork brute force attack mitigation
 (fbfam)
Message-ID: <20200912144722.GE3117@suse.de>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <alpine.LRH.2.21.2009121002100.17638@namei.org>
 <202009120055.F6BF704620@keescook>
 <20200912093652.GA3041@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200912093652.GA3041@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 11:36:52AM +0200, John Wood wrote:
> On Sat, Sep 12, 2020 at 12:56:18AM -0700, Kees Cook wrote:
> > On Sat, Sep 12, 2020 at 10:03:23AM +1000, James Morris wrote:
> > > On Thu, 10 Sep 2020, Kees Cook wrote:
> > >
> > > > [kees: re-sending this series on behalf of John Wood <john.wood@gmx.com>
> > > >  also visible at https://github.com/johwood/linux fbfam]
> > > >
> > > > From: John Wood <john.wood@gmx.com>
> > >
> > > Why are you resending this? The author of the code needs to be able to
> > > send and receive emails directly as part of development and maintenance.
> 
> I tried to send the full patch serie by myself but my email got blocked. After
> get support from my email provider it told to me that my account is young,
> and due to its spam policie I am not allow, for now, to send a big amount
> of mails in a short period. They also informed me that soon I will be able
> to send more mails. The quantity increase with the age of the account.
> 

If you're using "git send-email" then specify --confirm=always and
either manually send a mail every few seconds or use an expect script
like

#!/bin/bash
EXPECT_SCRIPT=
function cleanup() {
	if [ "$EXPECT_SCRIPT" != "" ]; then
		rm $EXPECT_SCRIPT
	fi
}
trap cleanup EXIT

EXPECT_SCRIPT=`mktemp`
cat > $EXPECT_SCRIPT <<EOF
spawn sh ./SEND
expect {
	"Send this email"   { sleep 10; exp_send y\\r; exp_continue }
}
EOF

expect -f $EXPECT_SCRIPT
exit $?

This will work if your provider limits the rate mails are sent rather
than the total amount.

-- 
Mel Gorman
SUSE Labs
