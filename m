Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E73CB573
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 11:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhGPJuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 05:50:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59364 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbhGPJuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:50:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9D39E1FD41;
        Fri, 16 Jul 2021 09:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626428875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qoZxm7nAIsKyzHcLr7bldC6ob5buyQDZHFnTnqE96Yc=;
        b=JMa071MwdtGdOTTtohUPQW1xJJHT2g8hdwdsSWiFO4JB9lnEVV/3B8y0ew4BWz5nZXZX++
        dqq3TpUK8lt9r0+TIwRNbmJ+3rp9WEIEuLMofDx3ppdqgAVhzETqZH6PopgE0+BUYHk4Fb
        E9yzykH2tJL6t+tvRsCR//iJUsEMjT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626428875;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qoZxm7nAIsKyzHcLr7bldC6ob5buyQDZHFnTnqE96Yc=;
        b=zyk+331H9PDBqUqn6oeJvWxCQKaewcnlbWAIZM8h9L3cq9elTFYZX7BfXIYCKfolPY9RhZ
        9kQUCZNQBfDfgHCA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 8FDB0A3BB0;
        Fri, 16 Jul 2021 09:47:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6D3611E087D; Fri, 16 Jul 2021 11:47:55 +0200 (CEST)
Date:   Fri, 16 Jul 2021 11:47:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: FAN_REPORT_CHILD_FID
Message-ID: <20210716094755.GD31920@quack2.suse.cz>
References: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
 <20210712111016.GC26530@quack2.suse.cz>
 <CAOQ4uxgnbirvr-KSMQyz-PL+Q_FmBF_OfSmWFEu6B0TYN-w1tg@mail.gmail.com>
 <20210712162623.GA9804@quack2.suse.cz>
 <CAOQ4uxgHeX3r4eJ=4OgksDnkddPqOs0a8JxP5VDFjEddmRcorA@mail.gmail.com>
 <YO469q9T7h0LBlIT@google.com>
 <CAOQ4uxgkMrMiNNA=Y2OKP4XYoiDMMZLZshzyviirmRzwQvjr2w@mail.gmail.com>
 <YPDKa0tZ+kIoT8Um@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPDKa0tZ+kIoT8Um@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 16-07-21 09:53:15, Matthew Bobrowski wrote:
> On Wed, Jul 14, 2021 at 03:09:56PM +0300, Amir Goldstein wrote:
> > I am still debating with myself between adding a new event type
> > (FAN_RENAME), adding a new report flag (FAN_REPORT_TARGET_FID)
> > that adds info records to existing MOVE_ events or some combination.
> 
> Well, if we went with adding a new event FAN_RENAME and specifying that
> resulted in the generation of additional
> FAN_EVENT_INFO_TYPE_DFID_NAME_{FROM,TO} information record types for an
> event, wouldn't it be weird as it doesn't follow the conventional mechanism
> of a listener asking for additional information records? As in,
> traditionally we'd intialize the notification group with a flag and then
> that flag controls whether or not one is permitted to receive events of a
> particular type that may or may not include information records?
> 
> Maybe a combination approach is needed in this instance, but this doesn't
> necessarily simplify things when attempting to document the API semantics
> IMO.

So there are couple of ways how to approach this I guess. One is that we
add a flag like FAN_REPORT_SECONDARY_DFID and FAN_REPORT_SECONDARY_NAME
which would add another DFID(+NAME) record of new type to rename event. In
principle these could be added to MOVED_FROM and/or MOVED_TO events
(probably both are useful). But I'd find the naming somewhat confusing and
difficult to sensibly describe.

That's why I think it may be clearer to go with new FAN_RENAME event that
will be triggered when the directory is on either end of rename(2) (source
or target). If DFID(+NAME) is enabled for the group, the event would report
both source and target DFIDs (and names if enabled) instead of one. I don't
think special FAN_REPORT_? flag to enable the second DFID would be useful
in this case (either for clarity or enabling some functionality).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
