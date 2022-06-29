Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C718555F2DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 03:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiF2Bgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 21:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2Bgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:36:42 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A49F25C7C;
        Tue, 28 Jun 2022 18:36:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A14B010E8ABB;
        Wed, 29 Jun 2022 11:36:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1o6MdA-00CI6R-5V; Wed, 29 Jun 2022 11:36:36 +1000
Date:   Wed, 29 Jun 2022 11:36:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] Add bpf_getxattr
Message-ID: <20220629013636.GL1098723@dread.disaster.area>
References: <20220628161948.475097-1-kpsingh@kernel.org>
 <20220628171325.ccbylrqhygtf2dlx@wittgenstein>
 <CACYkzJ4kWFwC82EAhtEYcMBPNe49zXd+uPBt1i09mVwLnoh0Bw@mail.gmail.com>
 <CACYkzJ766xv-9+jLg9mNZtdbLN3n=J+Y5ep4BjpS+vzv2B2auQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ766xv-9+jLg9mNZtdbLN3n=J+Y5ep4BjpS+vzv2B2auQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62bbaca7
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=JPEYwPQDsx4A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=Apa4kL6uXOTQHP40X84A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 07:21:42PM +0200, KP Singh wrote:
> On Tue, Jun 28, 2022 at 7:20 PM KP Singh <kpsingh@kernel.org> wrote:
> > On Tue, Jun 28, 2022 at 7:13 PM Christian Brauner <brauner@kernel.org> wrote:
> > > On Tue, Jun 28, 2022 at 04:19:43PM +0000, KP Singh wrote:
> > > > v4 -> v5
> > > >
> > > > - Fixes suggested by Andrii
> > > >
> > > > v3 -> v4
> > > >
> > > > - Fixed issue incorrect increment of arg counter
> > > > - Removed __weak and noinline from kfunc definiton
> > > > - Some other minor fixes.
> > > >
> > > > v2 -> v3
> > > >
> > > > - Fixed missing prototype error
> > > > - Fixes suggested by other Joanne and Kumar.
> > > >
> > > > v1 -> v2
> > > >
> > > > - Used kfuncs as suggested by Alexei
> > > > - Used Benjamin Tissoires' patch from the HID v4 series to add a
> > > >   sleepable kfunc set (I sent the patch as a part of this series as it
> > > >   seems to have been dropped from v5) and acked it. Hope this is okay.
> > > > - Added support for verifying string constants to kfuncs
> > >
> > > Hm, I mean this isn't really giving any explanation as to why you are
> > > doing this. There's literally not a single sentence about the rationale?
> > > Did you accidently forget to put that into the cover letter? :)
> >
> >
> > Yes, actually I did forget to copy paste :)
> >
> > Foundation for building more complex security policies using the
> > BPF LSM as presented in LSF/MM/BPF:
> >
> > http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-xattr.pdf\
> 
> And my copy paste skills are getting worse (with the back-slash removed):
> 
> http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-xattr.pdf

There's literally zero information in that link, so I still have no
clue on what this does and how it interacts with filesystem xattr
code.

So for those of us who have zero clue as to what you are trying to
do, please write a cover letter containing a non-zero amount of
information.  i.e.  a description of the problem, the threat model
being addressed, the design of the infrastructure that needs this
hook, document assumptions that have been made (e.g. for
accessing inode metadata atomically from random bpf contexts), what
xattr namespace(s) this hook should belong/be constrained to,
whether you're going to ask for a setxattr hook next, etc.

At minimum this is going to need a bunch of documentation for people
to understand how to use this - where can I find that?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
