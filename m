Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2FD6C8EE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Mar 2023 15:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjCYOmy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Mar 2023 10:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjCYOmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Mar 2023 10:42:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91DEA244;
        Sat, 25 Mar 2023 07:42:51 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32PAbT16025455;
        Sat, 25 Mar 2023 14:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=N/CPr3QIyT6WYPDl4+fUfmsOxwKhosOCupRnS3AUqtE=;
 b=V/bthX4On+RqhQtQqJSIEg7tA2iPc2+/hYfukB+fk/ewXLEr9tvGeQDvxDpG+JZmF8GD
 AQvff8AotrCQAx4328F0BLOKIjRiNtcElHSk3rPoMUJoJLOPxEU9s1+V4dyl0KAC3sdY
 Q8ic3wiTsyxDRjZtuN+DlmhNRxHVG59o/5Uo3TJ+4+dwf25gQ3HyNIWmJvK/mw6GksB0
 TEz107BRISgJY3jq12CAtIqwT3sc8o1sUfM5w98NVUBKoqR1YPZrp1S/khTQZ9qOZmmo
 AUd18ix2eDIM/X+cqmFwZ393QqOx5bbpWAJFd78fqcWprHPtb7qrTOxxJ4shCBbk0T7L Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3phse7fx04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 14:42:45 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32PEWqeQ005044;
        Sat, 25 Mar 2023 14:42:45 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3phse7fwyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 14:42:45 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32P2TOaI006609;
        Sat, 25 Mar 2023 14:42:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3phr7frgk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 14:42:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32PEgeD332047740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Mar 2023 14:42:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD7A020040;
        Sat, 25 Mar 2023 14:42:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA73F2004B;
        Sat, 25 Mar 2023 14:42:38 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.64.140])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 25 Mar 2023 14:42:38 +0000 (GMT)
Date:   Sat, 25 Mar 2023 20:12:36 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [RFC 04/11] ext4: Convert mballoc cr (criteria) to enum
Message-ID: <ZB8IB14yLaoY4+19@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
 <9670431b31aa62e83509fa2802aad364910ee52e.1674822311.git.ojaswin@linux.ibm.com>
 <20230309121122.vzfswandgqqm4yk5@quack3>
 <ZBRAZsvbcSBNJ+Pl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230323105537.rrecw5xqqzmw567d@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323105537.rrecw5xqqzmw567d@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fvLv7ewZvA-5Bl0JOk1yX1J20ivXn3C6
X-Proofpoint-GUID: A3uJjfTn_KbSt2kaqhkW-lovkw8mw1gP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=925 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303250120
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:55:37AM +0100, Jan Kara wrote:
> On Fri 17-03-23 15:56:46, Ojaswin Mujoo wrote:
> > On Thu, Mar 09, 2023 at 01:11:22PM +0100, Jan Kara wrote:
> > > Also when going for symbolic allocator scan names maybe we could actually
> > > make names sensible instead of CR[0-4]? Perhaps like CR_ORDER2_ALIGNED,
> > > CR_BEST_LENGHT_FAST, CR_BEST_LENGTH_ALL, CR_ANY_FREE. And probably we could
> > > deal with ordered comparisons like in:
> > I like this idea, it should make the code a bit more easier to
> > understand. However just wondering if I should do it as a part of this
> > series or a separate patch since we'll be touching code all around and 
> > I don't want to confuse people with the noise :) 
> 
> I guess a mechanical rename should not be really confusing. It just has to
> be a separate patch.
Alright, got it.
> 
> > > 
> > >                 if (cr < 2 &&
> > >                     (!sbi->s_log_groups_per_flex ||
> > >                      ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &
> > >                     !(ext4_has_group_desc_csum(sb) &&
> > >                       (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))))
> > >                         return 0;
> > > 
> > > to declare CR_FAST_SCAN = 2, or something like that. What do you think?
> > About this, wont it be better to just use something like
> > 
> > cr < CR_BEST_LENGTH_ALL 
> > 
> > instead of defining a new CR_FAST_SCAN = 2.
> 
> Yeah, that works as well.
> 
> > The only concern is that if we add a new "fast" CR (say between
> > CR_BEST_LENGTH_FAST and CR_BEST_LENGTH_ALL) then we'll need to make
> > sure we also update CR_FAST_SCAN to 3 which is easy to miss.
> 
> Well, you have that problem with any naming scheme (and even with numbers).
> So as long as names are all defined together, there's reasonable chance
> you'll remember to verify the limits still hold :)
haha that's true. Anyways, I'll try a few things and see what looks
good. Thanks for the suggestions.

Regards,
ojaswin
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
