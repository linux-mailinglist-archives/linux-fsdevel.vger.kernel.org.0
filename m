Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A6F797BB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 20:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343850AbjIGS1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 14:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbjIGS1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:27:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8F8CDE;
        Thu,  7 Sep 2023 11:26:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E5E521892;
        Thu,  7 Sep 2023 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694095296;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ztjzXo8ECQkm+ziRE+3z96HEQcCmUAuOigO8gJDffWQ=;
        b=XjwB0pXcivnoZAyq8zrXNIzsljnjvA0y9O81Q/UsuTpvyEI35kuT/0qMfQBPf/Y4Mvvv+t
        2F+GKaNx4Az5rNBAdwmkndCNkTt6RTQQ63DWHmrEr6sI/IeaQjHtg2s6f7m6FBvDs9UYIT
        SzHi+9epPYdYy08LEZ4jpr4MOeAN4Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694095296;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ztjzXo8ECQkm+ziRE+3z96HEQcCmUAuOigO8gJDffWQ=;
        b=cNZCzHPKRW+vPLyncEXQJC/jGKUf//EER6zvbMfcF68x7lQoRRMQVW1V84mF49Si7yvsoI
        qRBdzCG3QYwpRAAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E95F0138F9;
        Thu,  7 Sep 2023 14:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lX40OL/X+WSvTgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 14:01:35 +0000
Date:   Thu, 7 Sep 2023 15:55:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Message-ID: <20230907135503.GO3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230905165041.GF14420@twin.jikos.cz>
 <5a9ca846-e72b-3ee1-f163-dd9765b3b62e@igalia.com>
 <fe879df8-c493-e959-0f45-6a3621c128e7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe879df8-c493-e959-0f45-6a3621c128e7@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:49:05PM +0800, Anand Jain wrote:
> On 9/6/23 04:23, Guilherme G. Piccoli wrote:
> > On 05/09/2023 13:50, David Sterba wrote:
> >> [...]
> >> I'd like to pick this as a feature for 6.7, it's extending code we
> >> already have for metadata_uuid so this is a low risk feature. The only
> >> problem I see for now is the name, using the word 'single'.
> >>
> >> We have single as a block group profile name and a filesystem can exist
> >> on a single device too, this is would be confusing when referring to it.
> >> Single-dev can be a working name but for a final release we should
> >> really try to pick something more unique. I don't have a suggestion for
> >> now.
> >>
> >> The plan for now is that I'll add the patch to a topic branch and add it
> >> to for-next so it could be tested but there might be some updates still
> >> needed. Either as changes to this patch or as separate patches, that
> >> depends.
> >>
> > 
> > Hi David, thanks for your feedback! I agree with you that this name is a
> > bit confusing, we can easily change that! How about virtual-fsid?
> > I confess I'm not the best (by far!) to name stuff, so I'll be glad to
> > follow a suggestion from anyone here heheh
> > 
> 
> This feature might also be expanded to support multiple devices, so 
> removing 'single' makes sense.

I'm not sure how this would work. In case of the single device we can be
sure which device belongs to the filesystem, just need the incompat bit
and internal uuid to distinguish it from the others.

With multiple devices how could we track which belong to the same
filesystem? This is the same problem we already have with scanning and
duplicating block devices.

The only thing I see is to specify the devices as mount options,
possibly with the bit marking the devices as seen but not
scanned/registered and never considered for the automatic mount.

> virtual-fsid is good.
> or
> random-fsid

I'm thinking about something that would be closer to how the devices'
uuids can be duplicated, so cloned_fsid or duplicate_fsid/dup_fsid.
Virtual can be anything, random sounds too random.
