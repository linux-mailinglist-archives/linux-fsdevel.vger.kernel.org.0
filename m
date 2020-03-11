Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A63182A70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 09:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgCLIFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 04:05:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:3476 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgCLIFV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:05:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 01:05:20 -0700
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="236744025"
Received: from fpirou-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 01:05:18 -0700
From:   "Patrick Ohly" <patrick.ohly@intel.com>
To:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 00/20] virtiofs: Add DAX support
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
References: <20200304165845.3081-1-vgoyal@redhat.com>
Date:   Wed, 11 Mar 2020 14:38:03 +0100
Message-ID: <yrjh1rpzggg4.fsf@pohly-mobl1.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:
> This patch series adds DAX support to virtiofs filesystem. This allows
> bypassing guest page cache and allows mapping host page cache directly
> in guest address space.
>
> When a page of file is needed, guest sends a request to map that page
> (in host page cache) in qemu address space. Inside guest this is
> a physical memory range controlled by virtiofs device. And guest
> directly maps this physical address range using DAX and hence gets
> access to file data on host.
>
> This can speed up things considerably in many situations. Also this
> can result in substantial memory savings as file data does not have
> to be copied in guest and it is directly accessed from host page
> cache.

As a potential user of this, let me make sure I understand the expected
outcome: is the goal to let virtiofs use DAX (for increased performance,
etc.) or also let applications that use virtiofs use DAX?

You are mentioning using the host's page cache, so it's probably the
former and MAP_SYNC on virtiofs will continue to be rejected, right?

-- 
Best Regards

Patrick Ohly
