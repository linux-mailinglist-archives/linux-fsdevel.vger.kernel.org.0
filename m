Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0F452CFEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 11:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiESJzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiESJzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 05:55:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD319FB3;
        Thu, 19 May 2022 02:55:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 939DC21B4D;
        Thu, 19 May 2022 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652954142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RmpoQxYAX55RibJa2N3a7HEDdZ7I5Ic/L3VPlTrRmko=;
        b=bXtcUbeaNbg8crmPNanaMnYJISwc9FyP0b1FoxZe3cQjf8d6K9TR8pV96h5uy2p3vg9pv2
        LOe6Brtf+r4SWMZTpeJgH1Hi2bJPQUKsXn3HoJbhb5S5WRJ1H6Fhd+tHWsuWkbTZeqrw96
        7Lu+oXCBjU7/uxc1gycLjUufXzyXVYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652954142;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RmpoQxYAX55RibJa2N3a7HEDdZ7I5Ic/L3VPlTrRmko=;
        b=5wQeqgXsyYBdISfMT/PycsBgIuthy58kjE1cEx8ynBCm7PelOrkzZCaQqjfdT42JbWRcAc
        shAQMSno/nlEQ7BA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2E8CE2C142;
        Thu, 19 May 2022 09:55:42 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DBAEFA062F; Thu, 19 May 2022 11:55:41 +0200 (CEST)
Date:   Thu, 19 May 2022 11:55:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 2/3] fanotify: define struct members to hold response
 decision context
Message-ID: <20220519095541.ewpxcvgtzvl5y2so@quack3.lan>
References: <cover.1652730821.git.rgb@redhat.com>
 <1520f08c023d1e919b1a2af161d5a19367b6b4bf.1652730821.git.rgb@redhat.com>
 <CAOQ4uxjV-eNxJ=O_WFTTzspCxXZqpMdh3Fe-N5aB-h1rDr_1hQ@mail.gmail.com>
 <YoWKPcsySt9cJbtB@madcap2.tricolour.ca>
 <CAOQ4uxi+8HUqyGxQBNMqSong92nreOWLKdy9MCrYg8wgW9Dj4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi+8HUqyGxQBNMqSong92nreOWLKdy9MCrYg8wgW9Dj4g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 19-05-22 09:03:51, Amir Goldstein wrote:
> > > > + * size is determined by the extra information type.
> > > > + *
> > > > + * If the context type is Rule, then the context following is the rule number
> > > > + * that triggered the user space decision.
> > > > + */
> > > > +
> > > > +#define FAN_RESPONSE_INFO_NONE         0
> > > > +#define FAN_RESPONSE_INFO_AUDIT_RULE   1
> > > > +
> > > > +union fanotify_response_extra {
> > > > +       __u32 audit_rule;
> > > > +};
> > > > +
> > > >  struct fanotify_response {
> > > >         __s32 fd;
> > > >         __u32 response;
> > > > +       __u32 extra_info_type;
> > > > +       union fanotify_response_extra extra_info;
> > >
> > > IIRC, Jan wanted this to be a variable size record with info_type and info_len.
> >
> > Again, the intent was to make it fixed for now and change it later if
> > needed, but that was a shortsighted approach...
> >
> > I don't see a need for a len in all response types.  _NONE doesn't need
> > any.  _AUDIT_RULE is known to be 32 bits.  Other types can define their
> > size and layout as needed, including a len field if it is needed.
> >
> 
> len is part of a common response info header.
> It is meant to make writing generic code.
> So Jan's email.

Yes. The reason why I want 'type' + 'len' information for every extra
response type is so that the code can be layered properly. Fanotify has no
bussiness in understanding the details of the additional info (or its
expected length) passed from userspace. That is the knowledge that should
stay within the subsystem this info is for. So the length of info record
needs to be passed in the generic info header.

To give an example imagine a situation when we'd like to attach two
different info records to a response, each for a different subsystem. Then
fanotify has to split response buffer and pass each info to the target
subsystem or maybe we'd just pass all info to both subsystems and define
they should ignore info they don't understand but in either case we need to
have a way to be able to separate different info records without apriori
knowledge what they actually mean or what is their expected length.
 
> > > I don't know if we want to make this flexible enough to allow for multiple
> > > records in the future like we do in events, but the common wisdom of
> > > the universe says that if we don't do it, we will need it.
> >
> > It did occur to me that this could be used for other than audit, hence
> > the renaming of the ..."_NONE" macro.
> >
> > We should be able in the future to define a type that is extensible or
> > has multiple records.  We have (2^32) - 2 types left to work with.
> >
> 
> The way this was done when we first introduced event info
> records was the same. We only allowed one type of record
> and a single record to begin with, but the format allowed for
> extending to multiple records.
> 
> struct fanotify_event_metadata already had event_len and
> metadata_len, so that was convenient. Supporting multi
> records only required that every record has a header with its
> own len.
> 
> As far as I can tell, the case of fanotify_response is different
> because we have the count argument of write(), which serves
> as the total response_len.

Yes.

> If we ever want to be able to extend the base fanotify_response,
> add fields to it not as extra info records, then we need to add
> response_metadata_len to struct fanotify_response, but I think that
> would be over design.

Yeah, I don't think that will happen. The standard response metadata is
basically fixed by backward compatibility constraints. If we need to extend
it in the future, I would prefer the extension to be in a form of an extra
info record.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
