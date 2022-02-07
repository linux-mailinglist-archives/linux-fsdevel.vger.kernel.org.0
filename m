Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8264AB914
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 11:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbiBGKui (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 05:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352740AbiBGKp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:45:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944E0C043181;
        Mon,  7 Feb 2022 02:45:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04D37210E6;
        Mon,  7 Feb 2022 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644230756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/A6g4q5wX9FPq/iPkChx0DcndBL8m1J1RaDIQAqdgA=;
        b=IDyj5XKM5yuLYff3rASEV70DXQju7YYUpSSIVgOtw+/uNmuZy+2F6kro7M23//P4zY0jd1
        NYMCpdIwanKhyY8eSyZ8bZeOlq911YkWXfDvdM5OS0Py9FiKgbGtzSCpbJCqv4az/Jkp2J
        3X9kcad57THLdmJuLGs5Cn8ih0z9qgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644230756;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/A6g4q5wX9FPq/iPkChx0DcndBL8m1J1RaDIQAqdgA=;
        b=XXjJ0TI1gcuFsZ4vftzaqKuyrxYN+U1YvYnrNhEyAqjjaRYcJq+lI2DK/ByVKIqPpKBb3v
        y9pWIAzPK8IxN1Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42E3213B53;
        Mon,  7 Feb 2022 10:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1Eq0DmP4AGJsRwAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 07 Feb 2022 10:45:55 +0000
Date:   Mon, 7 Feb 2022 11:45:54 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20220207114554.7a739042@suse.de>
In-Reply-To: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jan 2022 07:14:13 +0000, Chaitanya Kulkarni wrote:

> Hi,
> 
> * Background :-
> -----------------------------------------------------------------------
> 
> Copy offload is a feature that allows file-systems or storage devices
> to be instructed to copy files/logical blocks without requiring
> involvement of the local CPU.
> 
> With reference to the RISC-V summit keynote [1] single threaded
> performance is limiting due to Denard scaling and multi-threaded
> performance is slowing down due Moore's law limitations. With the rise
> of SNIA Computation Technical Storage Working Group (TWG) [2],
> offloading computations to the device or over the fabrics is becoming
> popular as there are several solutions available [2]. One of the common
> operation which is popular in the kernel and is not merged yet is Copy
> offload over the fabrics or on to the device.
> 
> * Problem :-
> -----------------------------------------------------------------------
> 
> The original work which is done by Martin is present here [3]. The
> latest work which is posted by Mikulas [4] is not merged yet. These two
> approaches are totally different from each other. Several storage
> vendors discourage mixing copy offload requests with regular READ/WRITE
> I/O. Also, the fact that the operation fails if a copy request ever
> needs to be split as it traverses the stack it has the unfortunate
> side-effect of preventing copy offload from working in pretty much
> every common deployment configuration out there.
> 
> * Current state of the work :-
> -----------------------------------------------------------------------
> 
> With [3] being hard to handle arbitrary DM/MD stacking without
> splitting the command in two, one for copying IN and one for copying
> OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
> candidate. Also, with [4] there is an unresolved problem with the
> two-command approach about how to handle changes to the DM layout
> between an IN and OUT operations.
> 
> We have conducted a call with interested people late last year since 
> lack of LSFMMM and we would like to share the details with broader
> community members.
> 
> * Why Linux Kernel Storage System needs Copy Offload support now ?
> -----------------------------------------------------------------------
> 
> With the rise of the SNIA Computational Storage TWG and solutions [2],
> existing SCSI XCopy support in the protocol, recent advancement in the
> Linux Kernel File System for Zoned devices (Zonefs [5]), Peer to Peer
> DMA support in the Linux Kernel mainly for NVMe devices [7] and
> eventually NVMe Devices and subsystem (NVMe PCIe/NVMeOF) will benefit
> from Copy offload operation.
> 
> With this background we have significant number of use-cases which are
> strong candidates waiting for outstanding Linux Kernel Block Layer Copy
> Offload support, so that Linux Kernel Storage subsystem can to address
> previously mentioned problems [1] and allow efficient offloading of the
> data related operations. (Such as move/copy etc.)
> 
> For reference following is the list of the use-cases/candidates waiting
> for Copy Offload support :-
> 
> 1. SCSI-attached storage arrays.
> 2. Stacking drivers supporting XCopy DM/MD.
> 3. Computational Storage solutions.
> 7. File systems :- Local, NFS and Zonefs.
> 4. Block devices :- Distributed, local, and Zoned devices.
> 5. Peer to Peer DMA support solutions.
> 6. Potentially NVMe subsystem both NVMe PCIe and NVMeOF.
> 
> * What we will discuss in the proposed session ?
> -----------------------------------------------------------------------
> 
> I'd like to propose a session to go over this topic to understand :-
> 
> 1. What are the blockers for Copy Offload implementation ?
> 2. Discussion about having a file system interface.
> 3. Discussion about having right system call for user-space.
> 4. What is the right way to move this work forward ?
> 5. How can we help to contribute and move this work forward ?
> 
> * Required Participants :-
> -----------------------------------------------------------------------
> 
> I'd like to invite file system, block layer, and device drivers
> developers to:-
> 
> 1. Share their opinion on the topic.
> 2. Share their experience and any other issues with [4].
> 3. Uncover additional details that are missing from this proposal.

I'd like to attend this discussion. I've worked on the LIO XCOPY
implementation in drivers/target/target_core_xcopy.c and added Samba's
FSCTL_SRV_COPYCHUNK/FSCTL_DUPLICATE_EXTENTS_TO_FILE support.

Cheers, David
