Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C2F4A72C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 15:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344789AbiBBOMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 09:12:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33554 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbiBBOMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:12:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 392351F397;
        Wed,  2 Feb 2022 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643811124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+RcZpPqtnfLAwgIFAjYhXtgjx/0Wde9g5JtAXXXQ3Hk=;
        b=IoEmeC7b6SCa2pEE4x4Dcr5x3ja8fY7Iqi+JIo1sSpTPS9vz1jOYEZfrgpFXp6/Q2PP9bG
        EPo2LhvuC2c+jfaRIFc10W1Xuk2tVMkfXQEqszO9RIQ8vdszRnsmWfVKgfthMuG51OAxdv
        kXNtBvBnJ8Ky7zs95rRLzHyvl7UZ+w4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643811124;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+RcZpPqtnfLAwgIFAjYhXtgjx/0Wde9g5JtAXXXQ3Hk=;
        b=Ji9+WRMhtXbsUd8Nw/4DI0m71QiyLu0cugknNcqTwZpD2vPhslTP08V1vm03RHgLG0L6Ni
        TX9Morl3HlHdH3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C5F613BBC;
        Wed,  2 Feb 2022 14:12:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +glHCjSR+mGGYgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 14:12:04 +0000
Message-ID: <3a066f81-a53d-4d39-5efb-bd957443e7e2@suse.de>
Date:   Wed, 2 Feb 2022 15:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
From:   Hannes Reinecke <hare@suse.de>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: [LSF/MM/BPF TOPIC][LSF/MM/BPF ATTEND] TLS handshake for in-kernel
 consumers
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

nvme-over-tcp has the option to utilize TLS for encrypted traffic, but 
due to the internal design of the nvme-over-fabrics stack we cannot 
initiate the TLS connection from userspace (as the current in-kernel TLS 
implementation is designed).

This leaves us with two options:
1) Put TLS handshake into the kernel (which will be quite some
   discussion as it's arguably a userspace configuration)
2) Pass an in-kernel socket to userspace and have a userspace
   application to run the TLS handshake.

None of these options are quiet clear cut, as we will be have to put
quite some complexity into the kernel to do full TLS handshake (if we
were to go with option 1) or will have to design a mechanism to pass
an in-kernel socket to userspace as we don't do that currently (if we 
were going with option 2).

We have been discussing some ideas on how to implement option 2 
(together with Chuck Lever and the NFS crowd), but so far haven't been 
able to come up with a decent design.

So I would like to discuss with interested parties on how TLS handshake 
could be facilitated, and what would be the best design options here.

The proposed configd would be an option, but then we don't have that, 
either :-)

Required attendees:

Chuck Lever
James Bottomley
Sagi Grimberg
Keith Busch
Christoph Hellwig
David Howells

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
