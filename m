Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2D7796DC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 01:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbjIFXxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 19:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjIFXxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:53:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C1BBD;
        Wed,  6 Sep 2023 16:53:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D485DC433C7;
        Wed,  6 Sep 2023 23:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694044414;
        bh=XtfWjkXCT16PZ8Iew1KtMAcUnk1mv7fZCrzJguTA4lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vChG5V7GyAodqTSuiL659h+5n+krUB4o7CQH/hpRze7gI9MpAjoHDT+183JEtSjBo
         oO8cxAnq7dE17ALYfgmVHx/scf4fjUggYOxXsB34P3NX4CIuH3IFd3naRD0BVxwN3/
         dZYbEQ41bQXK5yHIUo/48cyyyWr4sQnus1Bq/vNu8QVF+lWAoYOm0PZY6uukSxwtiO
         GRQCk5vGEgaikF0ek6pVIiGjqwjil7i8+IqtL7L6s68t0pY4mi26GRzNJSZNYe9vGE
         TmfXVT5AuzHZr8+kJ1mHGwgWTfkgWqARtskhvvm9dwtl3JP+DWXPwugFIQg7LAydhu
         mfUN9zOHSozpg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1D885403F4; Wed,  6 Sep 2023 20:53:31 -0300 (-03)
Date:   Wed, 6 Sep 2023 20:53:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dsterba@suse.cz, Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZPkQ+whuhTT6JtKN@kernel.org>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
 <CAHk-=whaiVhuO7W1tb8Yb-CuUHWn7bBnJ3bM7bvcQiEQwv_WrQ@mail.gmail.com>
 <CAHk-=wi6EAPRzYttb+qnZJuzinUnH9xXy-a1Y5kvx5Qs=6xDew@mail.gmail.com>
 <ZPj1WuwKKnvVEZnl@kernel.org>
 <20230906231354.GX14420@twin.jikos.cz>
 <CAHk-=wh+RRhqgmpNN=WMz-4kkkcyNF0-a6NpRvxH9DjSTy9Ccg@mail.gmail.com>
 <ZPkPRpe4T9RgM/CV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPkPRpe4T9RgM/CV@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em Wed, Sep 06, 2023 at 08:46:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Sep 06, 2023 at 04:34:32PM -0700, Linus Torvalds escreveu:
> > On Wed, 6 Sept 2023 at 16:20, David Sterba <dsterba@suse.cz> wrote:
> > >     I think I've always seen an int for enums, unless it was
> > > explicitly narrowed in the structure (:8) or by __packed attribute in
> > > the enum definition.
 
> > 'int' is definitely the default (and traditional) behavior.
  
> > But exactly because enums can act very differently depending on
> > compiler options (and some of those may have different defaults on
> > different architectures), we should never ever have a bare 'enum' as
> > part of a structure in any UAPI.
  
> > In fact, having an enum as a bitfield is much better for that case.
  
> > Doing a quick grep shows that sadly people haven't realized that.
  
> > Now: using -fshort-enum can break a _lot_ of libraries exactly for
> > this kind of reason, so the kernel isn't unusual, and I don't know of
> > anybody who actually uses -fshort-enum. I'm mentioning -fshort-enum
> > not because it's likely to be used, but mainly because it's an easy
> > way to show some issues.
  
> > You can get very similar issues by just having unusual enum values.  Doing
 
> >    enum mynum { val = 0x80000000 };
  
> > does something special too.
  
> > I leave it to the reader to figure out, but as a hint it's basically
> > exactly the same issue as I was trying to show with my crazy
> > -fshort-enum example.
> 
> Two extra hints:
 
> ⬢[acme@toolbox perf-tools-next]$ grep KIND_ENUM64 include/uapi/linux/btf.h
> 	BTF_KIND_ENUM64		= 19,	/* Enumeration up to 64-bit values */
> /* BTF_KIND_ENUM64 is followed by multiple "struct btf_enum64".
> ⬢[acme@toolbox perf-tools-next]$
 
> ⬢[acme@toolbox perf-tools-next]$ pahole --help |& grep enum
>       --skip_encoding_btf_enum64   Do not encode ENUM64s in BTF.
> ⬢[acme@toolbox perf-tools-next]$
 
> :-)

Some examples:

[root@five perf-tools-next]# bpftool btf dump file /sys/kernel/btf/vmlinux  | grep -w ENUM64
[2954] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=28
[6519] ENUM64 'blake2b_iv' encoding=UNSIGNED size=8 vlen=8
[12990] ENUM64 '(anon)' encoding=UNSIGNED size=8 vlen=3
[16283] ENUM64 'netdev_priv_flags' encoding=UNSIGNED size=8 vlen=33
[21717] ENUM64 '(anon)' encoding=UNSIGNED size=8 vlen=11
[28247] ENUM64 'ib_uverbs_device_cap_flags' encoding=UNSIGNED size=8 vlen=28
[34836] ENUM64 'perf_callchain_context' encoding=UNSIGNED size=8 vlen=7
[48851] ENUM64 '(anon)' encoding=UNSIGNED size=8 vlen=9
[54703] ENUM64 'hmm_pfn_flags' encoding=UNSIGNED size=8 vlen=7
[root@five perf-tools-next]# pahole netdev_priv_flags
enum netdev_priv_flags {
	IFF_802_1Q_VLAN           = 1,
	IFF_EBRIDGE               = 2,
	IFF_BONDING               = 4,
	IFF_ISATAP                = 8,
	IFF_WAN_HDLC              = 16,
	IFF_XMIT_DST_RELEASE      = 32,
	IFF_DONT_BRIDGE           = 64,
	IFF_DISABLE_NETPOLL       = 128,
	IFF_MACVLAN_PORT          = 256,
	IFF_BRIDGE_PORT           = 512,
	IFF_OVS_DATAPATH          = 1024,
	IFF_TX_SKB_SHARING        = 2048,
	IFF_UNICAST_FLT           = 4096,
	IFF_TEAM_PORT             = 8192,
	IFF_SUPP_NOFCS            = 16384,
	IFF_LIVE_ADDR_CHANGE      = 32768,
	IFF_MACVLAN               = 65536,
	IFF_XMIT_DST_RELEASE_PERM = 131072,
	IFF_L3MDEV_MASTER         = 262144,
	IFF_NO_QUEUE              = 524288,
	IFF_OPENVSWITCH           = 1048576,
	IFF_L3MDEV_SLAVE          = 2097152,
	IFF_TEAM                  = 4194304,
	IFF_RXFH_CONFIGURED       = 8388608,
	IFF_PHONY_HEADROOM        = 16777216,
	IFF_MACSEC                = 33554432,
	IFF_NO_RX_HANDLER         = 67108864,
	IFF_FAILOVER              = 134217728,
	IFF_FAILOVER_SLAVE        = 268435456,
	IFF_L3MDEV_RX_HANDLER     = 536870912,
	IFF_NO_ADDRCONF           = 1073741824,
	IFF_TX_SKB_NO_LINEAR      = 2147483648,
	IFF_CHANGE_PROTO_DOWN     = 4294967296,
}

[root@five perf-tools-next]# pahole --hex ib_uverbs_device_cap_flags
enum ib_uverbs_device_cap_flags {
	IB_UVERBS_DEVICE_RESIZE_MAX_WR         = 0x1,
	IB_UVERBS_DEVICE_BAD_PKEY_CNTR         = 0x2,
	IB_UVERBS_DEVICE_BAD_QKEY_CNTR         = 0x4,
	IB_UVERBS_DEVICE_RAW_MULTI             = 0x8,
	IB_UVERBS_DEVICE_AUTO_PATH_MIG         = 0x10,
	IB_UVERBS_DEVICE_CHANGE_PHY_PORT       = 0x20,
	IB_UVERBS_DEVICE_UD_AV_PORT_ENFORCE    = 0x40,
	IB_UVERBS_DEVICE_CURR_QP_STATE_MOD     = 0x80,
	IB_UVERBS_DEVICE_SHUTDOWN_PORT         = 0x100,
	IB_UVERBS_DEVICE_PORT_ACTIVE_EVENT     = 0x400,
	IB_UVERBS_DEVICE_SYS_IMAGE_GUID        = 0x800,
	IB_UVERBS_DEVICE_RC_RNR_NAK_GEN        = 0x1000,
	IB_UVERBS_DEVICE_SRQ_RESIZE            = 0x2000,
	IB_UVERBS_DEVICE_N_NOTIFY_CQ           = 0x4000,
	IB_UVERBS_DEVICE_MEM_WINDOW            = 0x20000,
	IB_UVERBS_DEVICE_UD_IP_CSUM            = 0x40000,
	IB_UVERBS_DEVICE_XRC                   = 0x100000,
	IB_UVERBS_DEVICE_MEM_MGT_EXTENSIONS    = 0x200000,
	IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2A    = 0x800000,
	IB_UVERBS_DEVICE_MEM_WINDOW_TYPE_2B    = 0x1000000,
	IB_UVERBS_DEVICE_RC_IP_CSUM            = 0x2000000,
	IB_UVERBS_DEVICE_RAW_IP_CSUM           = 0x4000000,
	IB_UVERBS_DEVICE_MANAGED_FLOW_STEERING = 0x20000000,
	IB_UVERBS_DEVICE_RAW_SCATTER_FCS       = 0x400000000,
	IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING = 0x1000000000,
	IB_UVERBS_DEVICE_FLUSH_GLOBAL          = 0x4000000000,
	IB_UVERBS_DEVICE_FLUSH_PERSISTENT      = 0x8000000000,
	IB_UVERBS_DEVICE_ATOMIC_WRITE          = 0x10000000000,
}

[root@five perf-tools-next]#
