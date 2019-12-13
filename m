Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6703A11E6A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 16:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfLMPf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 10:35:57 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39054 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727831AbfLMPf5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:35:57 -0500
Received: from callcc.thunk.org (guestnat-104-132-34-105.corp.google.com [104.132.34.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBDFZlgP023296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 10:35:48 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 59E6C420E60; Fri, 13 Dec 2019 10:35:47 -0500 (EST)
Date:   Fri, 13 Dec 2019 10:35:47 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] automating file system benchmarks
Message-ID: <20191213153547.GA273569@mit.edu>
References: <20191213014742.GA250928@mit.edu>
 <CAOQ4uxhxx4EdaAsSPOztbx+0gfhixSi4fhBrhtDji1Dn4hgrow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhxx4EdaAsSPOztbx+0gfhixSi4fhBrhtDji1Dn4hgrow@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 07:12:03AM +0200, Amir Goldstein wrote:
> 
> Very nice :)
> You should post an [ANNOUNCE] every now and then.
> I rarely check upstream of xfstests-bld, because it just-works ;-)

Right now, the PTS support in gce-xfstests is very manual.  Right now
the VM is launched via "gce-xfstests pts", then you have to log into
the VM, "gce-xfstests ssh pts" after a few minutes, then run
"phoronix-test-suite pts/disk", answer a few questions, and then
afterwards run "pts-save --results" and then kill off the pts VM.

I want to get it to the point where "gce-xfstests pts" is sufficient,
where the benchmarks are run and the VM is automatically shut down
afterwards.  Also still to be done is to add support for kvm-xfstests.
That'll hopefully be done in the next month or so, as I have some free
time.

> I suppose you have access to a dedicated metal in the cloud for running
> your performance regression tests? Or at least a dedicated metal per execution.

I'm not currently using a dedicated VM currently.  I've been primarily
using a 1TB PD-SSD as the storage medium and a n1-standard-16 as the
VM type.  That's been fairly reliable.

Using GCE Local SSD is a little tricky because there is more than one
underlying hardware, and that can result in differing results across
different VM's.  What you *can* do is to just use the same VM, and
then kexec into different kernels each time.  This can be done
manually, by copying in a different kernel into /root/bzImage, and
then running /root/do_kexec, and then running the next benchmark.
Eventually my plan to support this with a  command like

gce-xfstests --kernel gs://$B/bzImage-4.19,gs://bz/$B/bzImage-5.3 \
	--local-ssd pts

The reason why Local SSD is interesting is that GCE's Persistent Disk
has a very different performance profile than HDD's or SSD's --- it
acts much more like a battery-backed enterprise storage array, in that
CACHE FLUSH's are super fast, as are random writes.  GCE Local SSD
acts like, well, a real high performance SSD, and it's good to
benchmark both.

> I have not looked into GCE, so don't know how easy it is and how expensive
> to use GCE this way.

A benchmark run does take longer than "gce-xfstests -g auto", since
you generally use a larger VM and a larger amount of storage.  A 1T
PD-SSD plus a n1-standard-16 VM is about a dollar an hour, and it's
3-4 hours to run the pts/disk benchmark suite.  So call it $3-4 for a
single performance test run.

> Is there any chance of Google donating this sort of resource for a performance
> regression test bot?

We're not at the point where we could run gce-xfstests (either for
functional or performance testing) as a bot.  There's still some
development work that needs to happen before that could be a reality.
For now, if there was a development team that wanted to use
gce-xfstests for performance and benchmarking, I'm happy to put them
in contact with the folks at Google which support open source
projects.

   	     		       	   		   - Ted
