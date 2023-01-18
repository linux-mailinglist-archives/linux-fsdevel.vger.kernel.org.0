Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E7B6726C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 19:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjARSZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 13:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjARSY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:24:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5099C56EFA;
        Wed, 18 Jan 2023 10:24:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBF192047F;
        Wed, 18 Jan 2023 18:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674066295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWh/oBqmYaCvmcaWdd5QGgFoMS7XEBOkKm6M0VQD564=;
        b=NzofIduHUlVwFvi286wUPNyNTZ3SwIXMrnP/WjotuDSLc//joRDKzGTLKS5bCpudj26Yrj
        +5vTJmEmMOlpaWzDh3fXBncXWTxV1igRQLajMCVH1ESIuhAM4gPotrsmt+PYDUNqrVapj5
        NC0DKzLaFXG8U4OIJ8TtlmGGWgV1UsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674066295;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWh/oBqmYaCvmcaWdd5QGgFoMS7XEBOkKm6M0VQD564=;
        b=3cwFSGttabKmPQg6FOSJYwgts0N0aIJulorDSZnYdtirdSskL6FrwrPm95EnHsajEXl0L+
        YL6us2LCby/VMRBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBD8A138FE;
        Wed, 18 Jan 2023 18:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7PzVLXc5yGMdZQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 18 Jan 2023 18:24:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1F863A06B2; Wed, 18 Jan 2023 19:24:55 +0100 (CET)
Date:   Wed, 18 Jan 2023 19:24:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v6 0/3] fanotify: Allow user space to pass back
 additional audit info
Message-ID: <20230118182455.fdcfsrdrj2u7f5ux@quack3>
References: <cover.1673989212.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673989212.git.rgb@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 17-01-23 16:14:04, Richard Guy Briggs wrote:
> The Fanotify API can be used for access control by requesting permission
> event notification. The user space tooling that uses it may have a
> complicated policy that inherently contains additional context for the
> decision. If this information were available in the audit trail, policy
> writers can close the loop on debugging policy. Also, if this additional
> information were available, it would enable the creation of tools that
> can suggest changes to the policy similar to how audit2allow can help
> refine labeled security.
> 
> This patchset defines a new flag (FAN_INFO) and new extensions that
> define additional information which are appended after the response
> structure returned from user space on a permission event.  The appended
> information is organized with headers containing a type and size that
> can be delegated to interested subsystems.  One new information type is
> defined to audit the triggering rule number.  
> 
> A newer kernel will work with an older userspace and an older kernel
> will behave as expected and reject a newer userspace, leaving it up to
> the newer userspace to test appropriately and adapt as necessary.  This
> is done by providing a a fully-formed FAN_INFO extension but setting the
> fd to FAN_NOFD.  On a capable kernel, it will succeed but issue no audit
> record, whereas on an older kernel it will fail.
> 
> The audit function was updated to log the additional information in the
> AUDIT_FANOTIFY record. The following are examples of the new record
> format:
>   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3137 subj_trust=3 obj_trust=5
>   type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F subj_trust=? obj_trust=?

Everything looks fine to me in this patchset so once patch 3/3 gets ack
from audit guys, I'll merge the series to my tree. Thanks for your work!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
