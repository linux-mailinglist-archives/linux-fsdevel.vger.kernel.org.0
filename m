Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD36D017B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 21:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfJHTv3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 15:51:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45097 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbfJHTv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:51:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id q7so10827565pgi.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2019 12:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tVOdpEM8zYwr6A95fEdbiKaAHkoR1ATc1z7R9NfKBdo=;
        b=sUYZuEYpMdnPU86NNv4TwIXjcaisunOJqKKRXDOVPRzLOM0ZJpMy5SNmT0gSKgUOyj
         5ezid2WQ3js3yBhJmf1kh0drLSkVNcKBhuQuQif4BT4PNVvd5yBA41trFJ7CXFA46rLM
         OmnsWOrSqsJS2puQZPUpkxk8FM1p3Lh9P1KHQXlQ5JRbXyzYAxTV+nPOi9P+r+e+VBhp
         iBWO5EreivSZJ8KQnnrHb5AGL1wsXBUfzkNVDQo2/iY/+FILPhS44AIm0eAZnuphuFoA
         ONsS0sC9LlY1eGreXLFO2Y9OP/RImUnNF6o8HXY4XdzYw/wPZ0diFgeHWQrl7fJJJHLu
         tQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tVOdpEM8zYwr6A95fEdbiKaAHkoR1ATc1z7R9NfKBdo=;
        b=rFOO7ixF5gfEHwJei30t4TuNmrPYgrBOpUWaPRwNe9wUD7SU+wmtcPke0uYWv0yR+3
         6ZmPhaYvJt3vQEwAxPL+p4ofQi8Tb3K7hrxymCCjn9nPslBhgVNIqM7swOSsRGeUSbJp
         lo2p7uepbuGyi4CMIa6xoAMnj88YZaXK8IbM8D8sR2hxRbFLslAgIX18AJcX93P1OdGh
         ih4t6kv7OjVzlbdNSWnUsACI/epDpTdnmenQrkNKK2q+17TZsKY/1k/OyU5vMj8IMTIP
         kuGPoC7KNjldEP01VOq4zde+vA/UKkrt0LIyx9QXQa5aT1sZ8DXRutmKeMyrrWiKJWFt
         osJw==
X-Gm-Message-State: APjAAAWWYHc29CfvYuFlt0C9lZqlSxIrJ/5D4YDjPbpFUdJ5qmlf7G2q
        HZsGRBaEen1Q2XaVRPhZd87edg==
X-Google-Smtp-Source: APXvYqw9rAK3pDOLRvbw0RQBkzSPpf/ogRjpf7rLxuQ1K92wrUhZlfrQXFPSd5BeidMsSu9S83VfvA==
X-Received: by 2002:aa7:800d:: with SMTP id j13mr41082251pfi.187.1570564287334;
        Tue, 08 Oct 2019 12:51:27 -0700 (PDT)
Received: from [100.112.64.176] ([104.133.9.96])
        by smtp.gmail.com with ESMTPSA id t13sm17427284pfh.12.2019.10.08.12.51.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Oct 2019 12:51:26 -0700 (PDT)
Date:   Tue, 8 Oct 2019 12:51:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Ian Kent <raven@themaw.net>, Karel Zak <kzak@redhat.com>
cc:     Hugh Dickins <hughd@google.com>, Laura Abbott <labbott@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: mount on tmpfs failing to parse context option
In-Reply-To: <20191008125610.s4fgnnba7yhclb3z@10.255.255.10>
Message-ID: <alpine.LSU.2.11.1910081219210.1204@eggly.anvils>
References: <d5b67332-57b7-c19a-0462-f84d07ef1a16@redhat.com> <d7f83334-d731-b892-ee49-1065d64a4887@redhat.com> <alpine.LSU.2.11.1910071655060.4431@eggly.anvils> <59784f8ac4d458a09d40706b554432b283083938.camel@themaw.net>
 <20191008125610.s4fgnnba7yhclb3z@10.255.255.10>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1683574798-1570564286=:1204"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1683574798-1570564286=:1204
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 8 Oct 2019, Karel Zak wrote:
> On Tue, Oct 08, 2019 at 08:38:18PM +0800, Ian Kent wrote:
> > > That's because the options in shmem_parse_options() are
> > > "size=3D4G,nr_inodes=3D0", which indeed looks like an attempt to
> > > retroactively limit size; but the user never asked "size=3D4G" there.
> >=20
> > I believe that's mount(8) doing that.
> > I don't think it's specific to the new mount api.
> >=20
> > AFAIK it's not new but it does mean the that things that come
> > through that have been found in mtab by mount(8) need to be
> > checked against the current value before failing or ignored if
> > changing them is not allowed.
> >=20
> > I wonder if the problem has been present for quite a while but
> > gone unnoticed perhaps.
> >=20
> > IIUC the order should always be command line options last and it
> > must be that way to honour the last specified option takes
> > precedence convention.
> >=20
> > I thought this was well known, but maybe I'm wrong ... and TBH
> > I wasn't aware of it until recently myself.
>=20
> Yep, the common behavior is "the last option wins". See man mount,
> remount option:
>=20
>   remount  functionality  follows  the standard way the mount command
>   works with options from fstab.  This means that mount does not read
>   fstab (or mtab) only when both device and dir are specified.
>=20
>         mount -o remount,rw /dev/foo /dir
>=20
>   After this call all old mount options are replaced and arbitrary
>   stuff from fstab (or mtab) is ignored, except the loop=3D option which
>   is  internally  generated  and  maintained by the mount command.
>=20
>         mount -o remount,rw  /dir
>=20
>   After  this call, mount reads fstab and merges these options with
>   the options from the command line (-o).  If no mountpoint is found
>   in fstab, then a remount with unspeci=E2=80=90 fied source is allowed.
>=20
>=20
> If you do not like this classic behavior than recent mount(8) versions
> provide --options-mode=3D{ignore,append,prepend,replace} to keep it in
> your hands.

Ian, Karel, many thanks for your very helpful education.
I've not yet digested all of it, but the important thing is...

Yes, you're right: my unexpectedly failing remount sequence fails
equally on a v5.3 kernel, and I'll hazard a guess that it has failed
like that ever since v2.4.8.  I just never noticed (and nobody else
ever complained) until I tried testing the new mount API: which at
least has the courtesy to put an error message reflecting the final
decision in dmesg, when the older kernels just silently EINVALed.

(And it's not impossible to remount thereafter: one just has to add
a "size=3D0" into the options, to allow the other options through.)

So, I've no more worries for v5.4 tmpfs mount, and if there's anything
that can be improved, that's a background job for me to look into later,
once I've spent more time understanding the info you've given me.

And Laura has confirmed that Al's security_sb_eat_lsm_opts() patch
fixes the "context" issue: thanks.

Hugh
--0-1683574798-1570564286=:1204--
