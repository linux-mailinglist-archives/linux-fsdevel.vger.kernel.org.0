Return-Path: <linux-fsdevel+bounces-1663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A1E7DD6B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 20:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82D01C20CAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 19:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171B82232C;
	Tue, 31 Oct 2023 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC322309
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 19:43:09 +0000 (UTC)
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B54483;
	Tue, 31 Oct 2023 12:43:07 -0700 (PDT)
Received: from quad.stoffel.org (097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id 5EB591E12B;
	Tue, 31 Oct 2023 15:43:05 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id 80C85A8B01; Tue, 31 Oct 2023 15:43:04 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25921.22728.501691.76305@quad.stoffel.home>
Date: Tue, 31 Oct 2023 15:43:04 -0400
From: "John Stoffel" <john@stoffel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
    Linus Torvalds  <torvalds@linux-foundation.org>,
    Amir Goldstein <amir73il@gmail.com>,
    Kent Overstreet  <kent.overstreet@linux.dev>,
    Christian Brauner <brauner@kernel.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    John Stultz <jstultz@google.com>,
    Thomas Gleixner <tglx@linutronix.de>,
    Stephen Boyd <sboyd@kernel.org>,
    Chandan Babu R <chandan.babu@oracle.com>,
    "Darrick J. Wong"  <djwong@kernel.org>,
    Theodore Ts'o <tytso@mit.edu>,
    Andreas Dilger  <adilger.kernel@dilger.ca>,
    Chris Mason <clm@fb.com>,
    Josef Bacik  <josef@toxicpanda.com>,
    David Sterba <dsterba@suse.com>,
    Hugh Dickins  <hughd@google.com>,
    Andrew Morton <akpm@linux-foundation.org>,
    Jan Kara  <jack@suse.de>,
    David Howells <dhowells@redhat.com>,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-xfs@vger.kernel.org,
    linux-ext4@vger.kernel.org,
    linux-btrfs@vger.kernel.org,
    linux-mm@kvack.org,
    linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
In-Reply-To: <b4c04efdde3bc7d107d0bdc68e100a94942aca3c.camel@kernel.org>
References: <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
	<ZTc8tClCRkfX3kD7@dread.disaster.area>
	<CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
	<d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
	<ZTjMRRqmlJ+fTys2@dread.disaster.area>
	<2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
	<ZTnNCytHLGoJY9ds@dread.disaster.area>
	<6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
	<ZUAwFkAizH1PrIZp@dread.disaster.area>
	<CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
	<ZUBbj8XsA6uW8ZDK@dread.disaster.area>
	<b4c04efdde3bc7d107d0bdc68e100a94942aca3c.camel@kernel.org>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)

>>>>> "Jeff" == Jeff Layton <jlayton@kernel.org> writes:

> On Tue, 2023-10-31 at 12:42 +1100, Dave Chinner wrote:
>> On Mon, Oct 30, 2023 at 01:11:56PM -1000, Linus Torvalds wrote:
>> > On Mon, 30 Oct 2023 at 12:37, Dave Chinner <david@fromorbit.com> wrote:
>> > > 
>> > > If XFS can ignore relatime or lazytime persistent updates for given
>> > > situations, then *we don't need to make periodic on-disk updates of
>> > > atime*. This makes the whole problem of "persistent atime update bumps
>> > > i_version" go away because then we *aren't making persistent atime
>> > > updates* except when some other persistent modification that bumps
>> > > [cm]time occurs.
>> > 
>> > Well, I think this should be split into two independent questions:
>> > 
>> >  (a) are relatime or lazytime atime updates persistent if nothing else changes?
>> 
>> They only become persistent after 24 hours or, in the case of
>> relatime, immediately persistent if mtime < atime (i.e. read after a
>> modification). Those are the only times that the VFS triggers
>> persistent writeback of atime, and it's the latter case (mtime <
>> atime) that is the specific trigger that exposed the problem with
>> atime bumping i_version in the first place.
>> 
>> >  (b) do atime updates _ever_ update i_version *regardless* of relatime
>> > or lazytime?
>> > 
>> > and honestly, I think the best answer to (b) would be that "no,
>> > i_version should simply not change for atime updates". And I think
>> > that answer is what it is because no user of i_version seems to want
>> > it.
>> 
>> As I keep repeating: Repeatedly stating that "atime should not bump
>> i_version" does not address the questions I'm asking *at all*.
>> 
>> > Now, the reason it's a single question for you is that apparently for
>> > XFS, the only thing that matters is "inode was written to disk" and
>> > that "di_changecount" value is thus related to the persistence of
>> > atime updates, but splitting di_changecount out to be a separate thing
>> > from i_version seems to be on the table, so I think those two things
>> > really could be independent issues.
>> 
>> Wrong way around - we'd have to split i_version out from
>> di_changecount. It's i_version that has changed semantics, not
>> di_changecount, and di_changecount behaviour must remain unchanged.
>> 

> I have to take issue with your characterization of this. The
> requirements for NFS's change counter have not changed. Clearly there
> was a breakdown in communications when it was first implemented in Linux
> that caused atime updates to get counted in the i_version value, but
> that was never intentional and never by design.

This has been bugging me, but all the references to NFS really mean
NFSv4.1 or newer, correct?  I can't see how any of this affects NFSv3
at all, and that's probably the still dominant form of NFS, right?  

John

