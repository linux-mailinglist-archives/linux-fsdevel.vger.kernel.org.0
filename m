Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E62184F3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 20:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCMTXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 15:23:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60031 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726683AbgCMTXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584127422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jsa0LGp0rUM3Qnr+H7a7s1WEexvMEYqOf4U0Q4GXvVg=;
        b=cQh9H5RVsApTikg6tWAcml4t0PAC/prGyOZtVUTNkZ2mNa3AHAjNLDS7wMpfrfISeyzsOL
        PsFzQ+vZCgSXNBVoEqLkoUPh2auHC+5H5EcEqzRtfamS/GhHBFnoyKb+dNQmv+W2GSk6Yc
        pM5kW7xFdOAupBS3sq6QaiA6LHiLzkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-GlmvpnEBNg-EFMfrEzwzvA-1; Fri, 13 Mar 2020 15:23:23 -0400
X-MC-Unique: GlmvpnEBNg-EFMfrEzwzvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41DEC1005512;
        Fri, 13 Mar 2020 19:23:21 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.rdu2.redhat.com [10.10.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A3AC92D36;
        Fri, 13 Mar 2020 19:23:09 +0000 (UTC)
Date:   Fri, 13 Mar 2020 15:23:06 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
        nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling
 the audit daemon
Message-ID: <20200313192306.wxey3wn2h4htpccm@madcap2.tricolour.ca>
References: <cover.1577736799.git.rgb@redhat.com>
 <20200204231454.oxa7pyvuxbj466fj@madcap2.tricolour.ca>
 <CAHC9VhQquokw+7UOU=G0SsD35UdgmfysVKCGCE87JVaoTkbisg@mail.gmail.com>
 <3142237.YMNxv0uec1@x2>
 <CAHC9VhTiCHQbp2SwK0Xb1QgpUZxOQ26JKKPsVGT0ZvMqx28oPQ@mail.gmail.com>
 <20200312202733.7kli64zsnqc4mrd2@madcap2.tricolour.ca>
 <CAHC9VhS9DtxJ4gvOfMRnzoo6ccGJVKL+uZYe6qqH+SPqD8r01Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhS9DtxJ4gvOfMRnzoo6ccGJVKL+uZYe6qqH+SPqD8r01Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-03-13 12:42, Paul Moore wrote:
> On Thu, Mar 12, 2020 at 4:27 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2020-02-12 19:09, Paul Moore wrote:
> > > On Wed, Feb 12, 2020 at 5:39 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > On Wednesday, February 5, 2020 5:50:28 PM EST Paul Moore wrote:
> > > > > > > > > ... When we record the audit container ID in audit_signal_info() we
> > > > > > > > > take an extra reference to the audit container ID object so that it
> > > > > > > > > will not disappear (and get reused) until after we respond with an
> > > > > > > > > AUDIT_SIGNAL_INFO2.  In audit_receive_msg() when we do the
> > > > > > > > > AUDIT_SIGNAL_INFO2 processing we drop the extra reference we took
> > > > > > > > > in
> > > > > > > > > audit_signal_info().  Unless I'm missing some other change you
> > > > > > > > > made,
> > > > > > > > > this *shouldn't* affect the syscall records, all it does is
> > > > > > > > > preserve
> > > > > > > > > the audit container ID object in the kernel's ACID store so it
> > > > > > > > > doesn't
> > > > > > > > > get reused.
> > > > > > > >
> > > > > > > > This is exactly what I had understood.  I hadn't considered the extra
> > > > > > > > details below in detail due to my original syscall concern, but they
> > > > > > > > make sense.
> > > > > > > >
> > > > > > > > The syscall I refer to is the one connected with the drop of the
> > > > > > > > audit container identifier by the last process that was in that
> > > > > > > > container in patch 5/16.  The production of this record is contingent
> > > > > > > > on
> > > > > > > > the last ref in a contobj being dropped.  So if it is due to that ref
> > > > > > > > being maintained by audit_signal_info() until the AUDIT_SIGNAL_INFO2
> > > > > > > > record it fetched, then it will appear that the fetch action closed
> > > > > > > > the
> > > > > > > > container rather than the last process in the container to exit.
> > > > > > > >
> > > > > > > > Does this make sense?
> > > > > > >
> > > > > > > More so than your original reply, at least to me anyway.
> > > > > > >
> > > > > > > It makes sense that the audit container ID wouldn't be marked as
> > > > > > > "dead" since it would still be very much alive and available for use
> > > > > > > by the orchestrator, the question is if that is desirable or not.  I
> > > > > > > think the answer to this comes down the preserving the correctness of
> > > > > > > the audit log.
> > > > > > >
> > > > > > > If the audit container ID reported by AUDIT_SIGNAL_INFO2 has been
> > > > > > > reused then I think there is a legitimate concern that the audit log
> > > > > > > is not correct, and could be misleading.  If we solve that by grabbing
> > > > > > > an extra reference, then there could also be some confusion as
> > > > > > > userspace considers a container to be "dead" while the audit container
> > > > > > > ID still exists in the kernel, and the kernel generated audit
> > > > > > > container ID death record will not be generated until much later (and
> > > > > > > possibly be associated with a different event, but that could be
> > > > > > > solved by unassociating the container death record).
> > > > > >
> > > > > > How does syscall association of the death record with AUDIT_SIGNAL_INFO2
> > > > > > possibly get associated with another event?  Or is the syscall
> > > > > > association with the fetch for the AUDIT_SIGNAL_INFO2 the other event?
> > > > >
> > > > > The issue is when does the audit container ID "die".  If it is when
> > > > > the last task in the container exits, then the death record will be
> > > > > associated when the task's exit.  If the audit container ID lives on
> > > > > until the last reference of it in the audit logs, including the
> > > > > SIGNAL_INFO2 message, the death record will be associated with the
> > > > > related SIGNAL_INFO2 syscalls, or perhaps unassociated depending on
> > > > > the details of the syscalls/netlink.
> > > > >
> > > > > > Another idea might be to bump the refcount in audit_signal_info() but
> > > > > > mark tht contid as dead so it can't be reused if we are concerned that
> > > > > > the dead contid be reused?
> > > > >
> > > > > Ooof.  Yes, maybe, but that would be ugly.
> > > > >
> > > > > > There is still the problem later that the reported contid is incomplete
> > > > > > compared to the rest of the contid reporting cycle wrt nesting since
> > > > > > AUDIT_SIGNAL_INFO2 will need to be more complex w/2 variable length
> > > > > > fields to accommodate a nested contid list.
> > > > >
> > > > > Do we really care about the full nested audit container ID list in the
> > > > > SIGNAL_INFO2 record?
> >
> > I'm inclined to hand-wave it away as inconvenient that can be looked up
> > more carefully if it is really needed.  Maybe the block above would be
> > safer and more complete even though it is ugly.
> >
> > > > > > > Of the two
> > > > > > > approaches, I think the latter is safer in that it preserves the
> > > > > > > correctness of the audit log, even though it could result in a delay
> > > > > > > of the container death record.
> > > > > >
> > > > > > I prefer the former since it strongly indicates last task in the
> > > > > > container.  The AUDIT_SIGNAL_INFO2 msg has the pid and other subject
> > > > > > attributes and the contid to strongly link the responsible party.
> > > > >
> > > > > Steve is the only one who really tracks the security certifications
> > > > > that are relevant to audit, see what the certification requirements
> > > > > have to say and we can revisit this.
> > > >
> > > > Sever Virtualization Protection Profile is the closest applicable standard
> > > >
> > > > https://www.niap-ccevs.org/Profile/Info.cfm?PPID=408&id=408
> > > >
> > > > It is silent on audit requirements for the lifecycle of a VM. I assume that
> > > > all that is needed is what the orchestrator says its doing at the high level.
> > > > So, if an orchestrator wants to shutdown a container, the orchestrator must
> > > > log that intent and its results. In a similar fashion, systemd logs that it's
> > > > killing a service and we don't actually hook the exit syscall of the service
> > > > to record that.
> > > >
> > > > Now, if a container was being used as a VPS, and it had a fully functioning
> > > > userspace, it's own services, and its very own audit daemon, then in this
> > > > case it would care who sent a signal to its auditd. The tenant of that
> > > > container may have to comply with PCI-DSS or something else. It would log the
> > > > audit service is being terminated and systemd would record that its tearing
> > > > down the environment. The OS doesn't need to do anything.
> > >
> > > This latter case is the case of interest here, since the host auditd
> > > should only be killed from a process on the host itself, not a process
> > > running in a container.  If we work under the assumption (and this may
> > > be a break in our approach to not defining "container") that an auditd
> > > instance is only ever signaled by a process with the same audit
> > > container ID (ACID), is this really even an issue?  Right now it isn't
> > > as even with this patchset we will still really only support one
> > > auditd instance, presumably on the host, so this isn't a significant
> > > concern.  Moving forward, once we add support for multiple auditd
> > > instances we will likely need to move the signal info into
> > > (potentially) s per-ACID struct, a struct whose lifetime would match
> > > that of the associated container by definition; as the auditd
> > > container died, the struct would die, the refcounts dropped, and any
> > > ACID held only the signal info refcount would be dropped/killed.
> >
> > Any process could signal auditd if it can see it based on namespace
> > relationships, nevermind container placement.  Some container
> > architectures would not have a namespace configuration that would block
> > this (combination of PID/user/IPC?).
> >
> > > However, making this assumption would mean that we are expecting a
> > > "container" to provide some level of isolation such that processes
> > > with a different audit container ID do not signal each other.  From a
> > > practical perspective I think that fits with the most (all?)
> > > definitions of "container", but I can't say that for certain.  In
> > > those cases where the assumption is not correct and processes can
> > > signal each other across audit container ID boundaries, perhaps it is
> > > enough to explain that an audit container ID may not fully disappear
> > > until it has been fetched with a SIGNAL_INFO2 message.
> >
> > I think more and more, that more complete isolation is being done,
> > taking advantage of each type of namespace as they become available, but
> > I know a nuber of them didn't find it important yet to use IPC, PID or
> > user namespaces which would be the only namespaces I can think of that
> > would provide that isolation.
> >
> > It isn't entirely clear to me which side you fall on this issue, Paul.
> 
> That's mostly because I was hoping for some clarification in the
> discussion, especially the relevant certification requirements, but it
> looks like there is still plenty of room for interpretation there (as
> usual).  I'd much rather us arrive at decisions based on requirements
> and not gut feelings, which is where I think we are at right now.

I don't disagree.

> > Can you pronounce on your strong preference one way or the other if the
> > death of a container coincide with the exit of the last process in that
> > namespace, or the fetch of any signal info related to it?
> 
> "pronounce on your strong preference"?  I've seen you use "pronounce"
> a few times now, and suggest a different word in the future; the
> connotation is not well received on my end.

I'm sorry.  I don't have any particular attachment to that word, but
I'll try to be concious to avoid it since you've expressed your aversion
to it.  I don't mean to load it down with any negative connotations, I'm
simply seeking clarity on your preferred technical style so I may follow
it.

> > I have a bias
> > to the former since the code already does that and I feel the exit of
> > the last process is much more relevant supported by the syscall record,
> > but could change it to the latter if you feel strongly enough about it
> > to block upstream acceptance.
> 
> At this point in time I believe the right thing to do is to preserve
> the audit container ID as "dead but still in existence" so that there
> is no confusion (due to reuse) if/when it finally reappears in the
> audit record stream.

I agree this seems safest.

> The thread has had a lot of starts/stops, so I may be repeating a
> previous suggestion, but one idea would be to still emit a "death
> record" when the final task in the audit container ID does die, but
> block the particular audit container ID from reuse until it the
> SIGNAL2 info has been reported.  This gives us the timely ACID death
> notification while still preventing confusion and ambiguity caused by
> potentially reusing the ACID before the SIGNAL2 record has been sent;
> there is a small nit about the ACID being present in the SIGNAL2
> *after* its death, but I think that can be easily explained and
> understood by admins.

Thinking quickly about possible technical solutions to this, maybe it
makes sense to have two counters on a contobj so that we know when the
last process in that container exits and can issue the death
certificate, but we still block reuse of it until all further references
to it have been resolved.  This will likely also make it possible to
report the full contid chain in SIGNAL2 records.  This will eliminate
some of the issues we are discussing with regards to passing a contobj
vs a contid to the audit_log_contid function, but won't eliminate them
all because there are still some contids that won't have an object
associated with them to make it impossible to look them up in the
contobj lists.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

