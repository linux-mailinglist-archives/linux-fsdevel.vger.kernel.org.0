Return-Path: <linux-fsdevel+bounces-4669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EEE801900
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 01:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA263281AFA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 00:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7282A8BF3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 00:40:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A186B9A;
	Fri,  1 Dec 2023 15:54:50 -0800 (PST)
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 3B1NrZqS019545;
	Fri, 1 Dec 2023 17:53:35 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 3B1NrW9C019544;
	Fri, 1 Dec 2023 17:53:32 -0600
Date: Fri, 1 Dec 2023 17:53:32 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed blob for integrity_iint_cache
Message-ID: <20231201235332.GA19345@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com> <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com> <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com> <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com> <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com> <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com> <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com> <20231201010549.GA8923@wind.enjellic.com> <660e8516-ec1b-41b4-9e04-2b9fabbe59ca@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <660e8516-ec1b-41b4-9e04-2b9fabbe59ca@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 01 Dec 2023 17:53:35 -0600 (CST)

On Fri, Dec 01, 2023 at 10:54:54AM -0800, Casey Schaufler wrote:

Good evening Casey, thanks for taking the time to respond.

> On 11/30/2023 5:05 PM, Dr. Greg wrote:
> > A suggestion has been made in this thread that there needs to be broad
> > thinking on this issue, and by extension, other tough problems.  On
> > that note, we would be interested in any thoughts regarding the notion
> > of a long term solution for this issue being the migration of EVM to a
> > BPF based implementation?
> >
> > There appears to be consensus that the BPF LSM will always go last, a
> > BPF implementation would seem to address the EVM ordering issue.
> >
> > In a larger context, there have been suggestions in other LSM threads
> > that BPF is the future for doing LSM's.  Coincident with that has come
> > some disagreement about whether or not BPF embodies sufficient
> > functionality for this role.
> >
> > The EVM codebase is reasonably modest with a very limited footprint of
> > hooks that it handles.  A BPF implementation on this scale would seem
> > to go a long ways in placing BPF sufficiency concerns to rest.
> >
> > Thoughts/issues?

> Converting EVM to BPF looks like a 5 to 10 year process. Creating a
> EVM design description to work from, building all the support functions
> required, then getting sufficient reviews and testing isn't going to be
> a walk in the park. That leaves out the issue of distribution of the
> EVM-BPF programs. Consider how the rush to convert kernel internals to
> Rust is progressing. EVM isn't huge, but it isn't trivial, either. Tetsuo
> had a good hard look at converting TOMOYO to BPF, and concluded that it
> wasn't practical. TOMOYO is considerably less complicated than EVM.

Interesting, thanks for the reflections.

On a functional line basis, EVM is 14% of the TOMOYO codebase, not
counting the IMA code.

Given your observations, one would than presume around a decade of
development effort to deliver a full featured LSM, ie. SELINUX, SMACK,
APPARMOR, TOMOYO in BPF form.

Very useful information, we can now return the thread to what appears
is going to be the vexing implementation of:

lsm_set_order(LSM_ORDER_FU_I_REALLY_AM_GOING_TO_BE_THE_LAST_ONE_TO_RUN);

:-)

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity

