Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BA5662B52
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 17:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjAIQfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 11:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjAIQfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:35:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C790CB8
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 08:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673282067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QF1a5tKcYgole0jC8DNiwCqj35Xt7SSZg6oSwq6Hd2U=;
        b=AEWEaKY1K6Yu6tk+utZQUv3aW6UH6+JedHH/mKK2ku5yYSP1UIosWf005W0UOCtAd6rCbi
        UZAwtteuqKDH5mkj/SuobuF6lVGTEhTKvQdujl4ZSMtISUJvP7etfCBqpNxZzNRlL/CQL0
        YjOP+tNxlwZ++SQmjxrr9cHYshRxeVI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-257-G9to2boQPOOvI4ToSddqbg-1; Mon, 09 Jan 2023 11:34:26 -0500
X-MC-Unique: G9to2boQPOOvI4ToSddqbg-1
Received: by mail-ed1-f69.google.com with SMTP id x13-20020a05640226cd00b0047ac11c9774so5643375edd.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 08:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QF1a5tKcYgole0jC8DNiwCqj35Xt7SSZg6oSwq6Hd2U=;
        b=oQGhDHMvckbLIxzHjAvft4NRrJTsjzRZkY6nvGnrhpP08hhsjAf/lhQ1aUFq1pZilW
         mdNgxK9pM7OT+98293qkALI3VNv5NIgzA85HL1pG5DNvq7pofmNXk8Vb4jCxcl6RqTr6
         T1lWv9I5A4lPwGgdz5DZBaEruDcm9a14d9V8o6VI7InrZ3AKD1vFO+kznPFTQwceaNa2
         ZzbwENjbKCPgnQ7SH+j5Eff3+u7V3o3IvTAE+EG6JYp1KkGPNAJEpWmkRbS2fS5yjArH
         9N6UAmgQJlWtGKA+cwqCPzjmr4iLCgIL27k09+IZrnsD540C6+2kYZRmhnBcmOH37jTF
         yOhQ==
X-Gm-Message-State: AFqh2kogX+03oPhBQl6B6zmfdpyKSSIMiwO+NCII59aGSSOb+fs5b1PY
        CoA9GkicPOkja056IKv66K5QxAWlpe48n63QivSKvwoRLSbT0T6hqKcRM9T4/1q0scsL6OX8cfM
        ShG6d//BgUgQLQ1st+A1NFYo3
X-Received: by 2002:a05:6402:6c9:b0:46c:2c94:d30b with SMTP id n9-20020a05640206c900b0046c2c94d30bmr71921200edy.33.1673282065576;
        Mon, 09 Jan 2023 08:34:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtWq3XRc3T8ZfdZYEscSzO7mgFjxgNBvHYXWSEdpXL8eGnTOec2uHkncxWnZmWXlhYf4PjAmw==
X-Received: by 2002:a05:6402:6c9:b0:46c:2c94:d30b with SMTP id n9-20020a05640206c900b0046c2c94d30bmr71921191edy.33.1673282065382;
        Mon, 09 Jan 2023 08:34:25 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id k26-20020a508ada000000b00487fc51c532sm4014812edk.33.2023.01.09.08.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 08:34:24 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:34:23 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 02/11] pagemap: add mapping_clear_large_folios()
 wrapper
Message-ID: <20230109163423.45o5moxlh7h6yvbb@aalbersh.remote.csb>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-3-aalbersh@redhat.com>
 <Y5i8igBLu+6OQt8H@casper.infradead.org>
 <20221213210813.GW3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213210813.GW3600936@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 08:08:13AM +1100, Dave Chinner wrote:
> On Tue, Dec 13, 2022 at 05:55:22PM +0000, Matthew Wilcox wrote:
> > On Tue, Dec 13, 2022 at 06:29:26PM +0100, Andrey Albershteyn wrote:
> > > Add wrapper to clear mapping's large folio flag. This is handy for
> > > disabling large folios on already existing inodes (e.g. future XFS
> > > integration of fs-verity).
> > 
> > I have two problems with this.  One is your use of __clear_bit().
> > We can use __set_bit() because it's done as part of initialisation.
> > As far as I can tell from your patches, mapping_clear_large_folios() is
> > called on a live inode, so you'd have to use clear_bit() to avoid races.
> 
> I think we can do without mapping_clear_large_folios() - we
> already have precedence for this sort of mapping state change with
> the DAX inode feature flag.  That is, we change the on-disk state in
> the ioctl context, but we don't change the in-memory inode state.
> Instead, we mark it I_DONTCACHEi to get it turfed from memory with
> expediency. Then when it is re-instantiated, we see the on-disk
> state and then don't enable large mappings on that inode.
> 
> That will work just fine here, I think.

Thanks for the suggestion, I will try to look into this. If it won't
work out I will stick to large folio switch, if no other objections.
In anyway I will remove the mapping_clear_large_folios() wrapper not
to encourage further use of such approach.

> 
> > The second is that verity should obviously be enhanced to support
> > large folios (and for that matter, block sizes smaller than PAGE_SIZE).
> > Without that, this is just a toy or a prototype.  Disabling large folios
> > is not an option.
> 
> Disabling large folios is very much an option. Filesystems must opt
> in to large mapping support, so they can also choose to opt out.
> i.e. large mappings is a filesystem policy decision, not a core
> infrastructure decision. Hence how we disable large mappings
> for fsverity enabled inodes is open to discussion, but saying we
> can't opt out of an optional feature is entirely non-sensical.
> 
> > I'm happy to work with you to add support for large folios to verity.
> > It hasn't been high priority for me, but I'm now working on folio support
> > for bufferhead filesystems and this would probably fit in.
> 
> Yes, we need fsverity to support multipage folios, but modifying
> fsverity is outside the scope of initially enabling fsverity support
> on XFS.  This patch set is about sorting out the on-disk format
> changes and interfacing with the fsverity infrastructure to enable
> the feature to be tested and verified.
> 
> Stuff like large mapping support in fsverity is a future concern,
> not a show-stopper for initial feature support. We don't need every
> bell and whistle in the initial merge....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

Thanks
Andrey

