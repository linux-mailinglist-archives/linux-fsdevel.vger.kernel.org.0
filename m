Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8ED6CB009
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 22:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjC0Ujo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 16:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjC0Ujn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:39:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D35135;
        Mon, 27 Mar 2023 13:39:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so13047481pjb.4;
        Mon, 27 Mar 2023 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679949582; x=1682541582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObIVazuLedmhVZJez+PSFU43TenUmtQ8TSYcPMuU/jk=;
        b=Vcc3QbMUdQltz74zXwK4M3A/gD/97stMVMWaQSV+2Ak2Pbw0qIpiyaOo6vNPB9fA2T
         YbFyqCYxP5WnDiT3Tql0Y+n2ZpdB36iiX8gxne/BzqT/GCUorTV+4ORYL/sH85DJrWJM
         zJheGLpXByjCjyUPuy5X3A4KjRSu/oEOyWDztRVi/ZBozTF24fndbycuDnBMmhTPOM0k
         FAinhpprVUfX/7JwXnvSJYSBAEIn9C45p3HdMhuMA8ZWEQBxVSsmWwebIaboKh2Li81p
         WZGFN6G4U7eYqP2UztmtHPloBvAtUEUX+li5Ib2zV4XB51UlzDQe52vvmOXozgZpNIth
         szCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679949582; x=1682541582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObIVazuLedmhVZJez+PSFU43TenUmtQ8TSYcPMuU/jk=;
        b=moYRurV1eSk9cVugMKGMpXAc5wZ3fycEpy6kgCYN5EXIFEi8p1EdpWzTEeKcV40Pnd
         iF6FnujxpFYBYrijB2CigKQmejmhv9epknPdYJCjCIByaiqeBvtiMnWGXE2aFDZg7jKZ
         T2SoZLhKvHs9ZIPVkPIl+ZLypT5w78p8WP2UVwKjWBfoI6fyogm9oK6cNUrKw1oDw4dn
         kS0/5sxnG84lA7BJPsRXhcDER8m/ZwsYzYP/eJjHDKqL4vKvdfH/CKjNjtbnmGLwjGWM
         /hoPqEoW1c6b3a+zlgeRSlOZzv/nLgEYnAgjcR1rpRIhJmDmZIkfvog5q43m7X1kN2YH
         dqfw==
X-Gm-Message-State: AAQBX9dM/WfWbxvsc0ZGWLACxNO4+5S2m4Cb1UYrOrvb/YfGn77m/K3Y
        0hFcJpqjAyi6V/QM/Fb9N6o=
X-Google-Smtp-Source: AK7set/QzeY8WJz+u9vl8XJyFVi5CfiNP74RpD3vaKFutxcPxN/4hVtPKppeKkaI6JT3PA5UawxOSA==
X-Received: by 2002:a17:90b:1241:b0:233:a836:15f4 with SMTP id gx1-20020a17090b124100b00233a83615f4mr10440658pjb.1.1679949582086;
        Mon, 27 Mar 2023 13:39:42 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902b19800b0019e5fc21663sm19387378plr.218.2023.03.27.13.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:39:41 -0700 (PDT)
Date:   Mon, 27 Mar 2023 20:39:39 +0000
From:   Alok Tiagi <aloktiagi@gmail.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David.Laight@aculab.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, hch@infradead.org, aloktiagi@gmail.com
Subject: Re: [RFC v4 2/2] file, epoll: Implement do_replace() and
 eventpoll_replace()
Message-ID: <ZCH/C89TwQ/aM1Rr@ip-172-31-38-16.us-west-2.compute.internal>
References: <20230324063422.1031181-2-aloktiagi@gmail.com>
 <ZBzRfDnHaEycE72s@ip-172-31-38-16.us-west-2.compute.internal>
 <20230324082344.xgze2vu3ds2kubcz@wittgenstein>
 <ZB2o8cs+VTQlz5GA@tycho.pizza>
 <20230327090106.zylztuk77vble7ye@wittgenstein>
 <ZCGU5JBg02+DU6JN@tycho.pizza>
 <ZCGXNwvymHVJ7O6K@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCGXNwvymHVJ7O6K@tycho.pizza>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:16:39AM -0600, Tycho Andersen wrote:
> On Mon, Mar 27, 2023 at 07:06:46AM -0600, Tycho Andersen wrote:
> > On Mon, Mar 27, 2023 at 11:01:06AM +0200, Christian Brauner wrote:
> > > On Fri, Mar 24, 2023 at 07:43:13AM -0600, Tycho Andersen wrote:
> > > > Perhaps we could add a flag that people could set from SECCOMP_ADDFD
> > > > asking for this extra behavior?
> > > 
> > >         +       if (fd > 0 && addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_EPOLL) {
> > >         +               /*
> > >         +                * - retrieve old struct file that addfd->fd refered to if any.
> > >         +                * - call your epoll seccomp api to update the references in the epoll instance
> > >         +                */
> > > 			epoll_seccomp_notify()
> > >         +       }
> > >         +
> > >         +       if (fd > 0 && addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_IO_URING) {
> > >         +               /*
> > >         +                * - call your io_uring seccomp api to update the references in the io_uring instance
> > >         +                */
> > > 			io_uring_seccomp_notify()
> > >         +       }
> > 
> > Looks reasonable to me, thanks.
> 
> One change I might suggest is only using a single flag bit -- we don't
> need to consume all of seccomp's remaining flag bits with the various
> subsystems. If you want to do this logic for epoll, you almost
> certainly want it for io_uring, select, and whatever else is out
> there.
> 
> Tycho

Thank you for your comment and thoughts on this Christian. The per-subsystem
helper and calling this from seccomp add fd looks like a cleaner API. I'll
address the changes in v5.
